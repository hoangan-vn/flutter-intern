import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/config/enum/medication_enum.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/medication/medication_repository.dart';
import 'package:safebump/src/network/data/note/note_repository.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/medications/medication.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/alarm_noti.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/datetime_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/calendar/month_calendar.dart';

class AddMedicationBloc extends Cubit<AddMedicationState> {
  AddMedicationBloc() : super(AddMedicationState());

  void initialize(MMedication rawMedication) async {
    emit(state.copyWith(
      name: rawMedication.name,
      doseType: rawMedication.doseType,
      amount: rawMedication.amount,
      note: rawMedication.note,
      time: rawMedication.time,
      nameInit: rawMedication.note,
    ));
  }

  void onChangedMedicationName(String text) {
    emit(state.copyWith(name: text, nameError: ''));
  }

  bool isNameInvalid(BuildContext context) {
    if (StringUtils.isNullOrEmpty(state.name)) {
      emit(state.copyWith(nameError: S.of(context).thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _isRemindTimeLack() {
    return isNullOrEmpty(state.time);
  }

  void onPressSaveButton(BuildContext context, String? id) async {
    if (state.status == AddMedicationStatus.loading) return;
    if (_isRemindTimeLack()) {
      emit(state.copyWith(
          status: AddMedicationStatus.fail,
          timeError: S.of(context).pleaseAddRemindTime));
      return;
    }
    emit(state.copyWith(status: AddMedicationStatus.loading));
    XToast.showLoading();
    final medicationId = id ?? StringUtils.createGenerateRandomText(length: 20);
    final medication = MMedication(
        id: medicationId,
        name: state.name,
        doseType: state.doseType,
        amount: state.amount,
        note: state.note,
        frequency: state.frequency,
        time: state.time ?? []);
    try {
      final result = await GetIt.I
          .get<MedicationRepository>()
          .updateMedication(medication);
      if (result.data == false) {
        final result =
            await GetIt.I.get<MedicationRepository>().addMedication(medication);
        if (result.data == null) {
          emit(state.copyWith(status: AddMedicationStatus.fail));
          XToast.hideLoading();
          XToast.error(S.text.someThingWentWrong);
          return;
        }
        xLog.e("Add new success");
        await _createNote();
        _registerRemindAlarm();
        emit(state.copyWith(status: AddMedicationStatus.success));
        XToast.hideLoading();
        AppCoordinator.pop(true);
        return;
      }
      xLog.e("Update success");
      await _createNote(isUpdate: true);
      emit(state.copyWith(status: AddMedicationStatus.success));
      XToast.hideLoading();
      AppCoordinator.pop(true);
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: AddMedicationStatus.fail));
      XToast.hideLoading();
      XToast.error(S.text.someThingWentWrong);
    }
  }

  void setAmount(double value) {
    emit(state.copyWith(amount: value));
  }

  void setDoseType(String doseType) {
    emit(state.copyWith(doseType: DoseType.gettype(doseType)));
  }

  void setNotes(String notes) {
    emit(state.copyWith(note: notes, nameInit: ''));
  }

  void showBottomSheetDateTimePicker(BuildContext context,
      {required String title,
      required DateTimePickerType type,
      required Function(DateTime) onChanged}) async {
    await showBoardDateTimePicker(
      context: context,
      pickerType: type,
      enableDrag: false,
      options: BoardDateTimeOptions(
        showDateButton: false,
        boardTitle: title,
        boardTitleTextStyle:
            AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f16),
        activeColor: AppColors.primary,
      ),
    ).then((value) {
      onChangedListRemindTime(value ?? DateTime.now());
    });
  }

  void onChangedListRemindTime(DateTime time) {
    List<String> listRemindTime = state.time ?? [];
    if (listRemindTime.contains(time.toHHmm)) return;
    listRemindTime.add(time.toHHmm);
    emit(state.copyWith(time: listRemindTime, timeError: ''));
  }

  void removeRemindTime(String time) {
    List<String> listRemindTime = state.time ?? [];
    if (!listRemindTime.contains(time)) return;
    listRemindTime.remove(time);
    emit(state.copyWith(time: listRemindTime));
  }

  Future<void> _createNote({bool isUpdate = false}) async {
    final now = DateTime.now();
    try {
      for (int i = 0; i < 31; i++) {
        if (isUpdate) {
          final listNote =
              await _getNotesInSelectedDay(now.add(Duration(days: i)));
          final medicationUpdatedId = listNote
              .where((element) {
                if (StringUtils.isNullOrEmpty(element.medicine)) return false;
                return (element.medicine!.contains(state.name));
              })
              .firstOrNull
              ?.id;
          if (medicationUpdatedId != null) {
            await GetIt.I
                .get<NotesLocalRepo>()
                .upsert(NotesEntityData(
                    id: medicationUpdatedId,
                    title: S.text.medication,
                    detail: state.note,
                    medicine: state.name,
                    time: DateTimeUtils.fromHHmm(state.time?.first ?? ''),
                    type: NoteType.reminder.toNoteTypeText(),
                    date: now.add(Duration(days: i)).toMMMdy))
                .then((value) async {
              await _syncingToFirebase(now.add(Duration(days: i)));
            });
            continue;
          }
        }
        await GetIt.I
            .get<NotesLocalRepo>()
            .insertDetail(NotesEntityData(
                id: StringUtils.createGenerateRandomText(length: 20),
                title: S.text.medication,
                detail: state.note,
                medicine: state.name,
                time: DateTimeUtils.fromHHmm(state.time?.first ?? ''),
                type: NoteType.reminder.toNoteTypeText(),
                date: now.add(Duration(days: i)).toMMMdy))
            .then((value) async {
          await _syncingToFirebase(now.add(Duration(days: i)));
        });
      }
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _syncingToFirebase(DateTime date) async {
    try {
      final notesInSelectedDay = await _getNotesInSelectedDay(date);
      if (notesInSelectedDay.isEmpty) {
        return;
      }
      final dataUpsertDay = MCalendarExt.toListMCalendar(notesInSelectedDay);
      await GetIt.I.get<NoteRepository>().upsertNote(dataUpsertDay.first);
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<List<NotesEntityData>> _getNotesInSelectedDay(
      DateTime dateSelected) async {
    try {
      final notes = await GetIt.I
          .get<NotesLocalRepo>()
          .getDetailByDate(date: dateSelected.toMMMdy)
          .get();
      return notes;
    } catch (e) {
      xLog.e(e);
      return [];
    }
  }

  void _registerRemindAlarm() {
    for (int i = 0; i < (state.time ?? []).length; i++) {
      XAlarm.setupAlarm(
          id: i,
          title: S.text.medication,
          body: '${state.name} \n${state.note}',
          time: DateTimeUtils.fromHHmm(state.time![i]));
    }
  }
}

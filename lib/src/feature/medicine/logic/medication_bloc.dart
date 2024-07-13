// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/medicine/logic/medication_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/medication/medication_repository.dart';
import 'package:safebump/src/network/data/note/note_repository.dart';
import 'package:safebump/src/network/model/calendar/calendar.dart';
import 'package:safebump/src/network/model/medications/medication.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/utils.dart';

class MedicationBloc extends Cubit<MedicationState> {
  MedicationBloc()
      : super(MedicationState(listMedication: List.empty(growable: true)));

  Future<void> inital() async {
    _createLoadingScreen();
    await _getAllMedicationFromFirebase();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: MedicationScreenStatus.fetching));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getAllMedicationFromFirebase() async {
    try {
      final result =
          await GetIt.I.get<MedicationRepository>().getAllMedications();
      if (result.data == null) {
        emit(state.copyWith(status: MedicationScreenStatus.fail));
        _hideLoadingScreen();
        return;
      }
      emit(state.copyWith(
        listMedication: result.data,
        status: MedicationScreenStatus.success,
      ));
      _hideLoadingScreen();
    } catch (e) {
      xLog.e(e);
      _hideLoadingScreen();
      emit(state.copyWith(status: MedicationScreenStatus.fail));
    }
  }

  void reloadPage(BuildContext context, bool isSuccess) async {
    if (isSuccess) {
      await inital();
    }
  }

  Future<void> deleteMedication(
      BuildContext context, MMedication medication) async {
    try {
      XToast.showLoading();
      final result = await GetIt.I
          .get<MedicationRepository>()
          .deleteMedication(medication);
      if (result.data == true) {
        _deleteNote(medication: medication);
        XToast.hideLoading();
        reloadPage(context, true);
        return;
      }
      XToast.hideLoading();
      XToast.error(S.of(context).someThingWentWrong);
    } catch (e) {
      xLog.e(e);
      XToast.hideLoading();
      XToast.error(e.toString());
    }
  }

  void _deleteNote({required MMedication medication}) async {
    final now = DateTime.now();
    try {
      final listMedicationNotes = await _getNotesByMedicine(medication.name);
      for (NotesEntityData note in listMedicationNotes) {
        await GetIt.I.get<NotesLocalRepo>().deleteNoteById(note.id);
      }
      for (int i = 0; i < 31; i++) {
        await _syncingToFirebase(now.add(Duration(days: i)));
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

  Future<List<NotesEntityData>> _getNotesByMedicine(String medicine) async {
    try {
      final notes = await GetIt.I
          .get<NotesLocalRepo>()
          .getDetailByMedicineName(name: medicine)
          .get();
      return notes;
    } catch (e) {
      xLog.e(e);
      return [];
    }
  }
}

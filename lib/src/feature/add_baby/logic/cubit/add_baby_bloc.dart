import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/add_baby/logic/state/add_baby_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/baby/baby_repo.dart';
import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/utils/datetime_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class AddBabyBloc extends Cubit<AddBabyState> {
  AddBabyBloc() : super(AddBabyState());

  void onChangedBabyName(String name) {
    emit(state.copyWith(babyName: name, errorBabyName: ''));
  }

  void onChangedBabyGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void onChangedBabyBirthDate(DateTime babyBirthDate) {
    emit(state.copyWith(babyBirthDate: babyBirthDate, errorBabyBirthDate: ''));
  }

  void onChangedBabyBirthTime(DateTime babyBirthTime) {
    emit(state.copyWith(babyBirthTime: babyBirthTime, errorBabyBirthTime: ''));
  }

  void onChangedBabyPicture(String imagePath) {
    emit(state.copyWith(babyImage: imagePath));
  }

  void onChangedBabyWeight(double weight) {
    emit(state.copyWith(birthWeight: weight, errorBirthWeight: ''));
  }

  void onChangedBabyHeight(double height) {
    emit(state.copyWith(birthHeight: height, errorBirthHeight: ''));
  }

  void onChangedBirthExperience(String experience) {
    emit(state.copyWith(birthExperience: experience));
  }

  Future<void> saveBabyInfor(BuildContext context) async {
    if (state.status == AddBabyScreenStatus.saving) return;
    if (_checkInvalidInforData()) {
      emit(state.copyWith(status: AddBabyScreenStatus.fail));
      return;
    }
    emit(state.copyWith(status: AddBabyScreenStatus.saving));
    final idGenerate = StringUtils.createGenerateRandomText(length: 16);
    final baby = BabyInforEntityData(
      id: idGenerate,
      name: state.babyName,
      type: state.type.getBabyTypeText(),
      date: DateTimeUtils.addTimeIntoDate(
          date: state.babyBirthDate!, time: state.babyBirthTime!),
      gender: state.gender.getBabyGenderText(context),
      height: state.birthHeight,
      weight: state.birthWeight,
    );
    try {
      await GetIt.I.get<BabyInforLocalRepo>().insertDetail(baby);
      final result = await GetIt.I
          .get<BabyRepository>()
          .getOrAddBaby(MBaby.convertFromBabyEntityData(baby));
      if (result.data != null) {
        emit(state.copyWith(status: AddBabyScreenStatus.success));
        UserPrefs.I.setPergnancyDay(state.babyBirthDate ?? DateTime.now());
        AppCoordinator.pop();
        AppCoordinator.pop(true);
      }
    } catch (e) {
      xLog.e(e);
      XToast.error(S.text.someThingWentWrong);
      emit(state.copyWith(status: AddBabyScreenStatus.fail));
    }
  }

  bool _checkInvalidInforData() {
    bool isInvalidName = _checkInvalidName(state.babyName);
    bool isInvalidWeight = _checkInvalidWeight(state.birthWeight);
    bool isInvalidHeight = _checkInvalidHeight(state.birthHeight);
    bool isInvalidBirthDate = _checkInvalidBirthDate(state.babyBirthDate);
    bool isInvalidBirthTime = _checkInvalidBirthTime(state.babyBirthTime);
    return isInvalidName &&
        isInvalidHeight &&
        isInvalidWeight &&
        isInvalidBirthDate &&
        isInvalidBirthTime;
  }

  bool _checkInvalidName(String babyName) {
    if (StringUtils.isNullOrEmpty(babyName)) {
      emit(state.copyWith(errorBabyName: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _checkInvalidWeight(double babyWeight) {
    if (isNullOrEmpty(babyWeight)) {
      emit(state.copyWith(errorBirthWeight: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _checkInvalidHeight(double babyHeight) {
    if (isNullOrEmpty(babyHeight)) {
      emit(state.copyWith(errorBirthHeight: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _checkInvalidBirthDate(DateTime? babyBirthDate) {
    if (babyBirthDate == null) {
      emit(state.copyWith(errorBabyBirthDate: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _checkInvalidBirthTime(DateTime? babyBirthTime) {
    if (babyBirthTime == null) {
      emit(state.copyWith(errorBabyBirthTime: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  void showBottomSheetDateTimePicker(BuildContext context,
      {required String title,
      required DateTimePickerType type,
      required Function(DateTime) onChanged}) async {
    await showBoardDateTimePicker(
      context: context,
      pickerType: type,
      options: BoardDateTimeOptions(
        boardTitle: title,
        activeColor: AppColors.primary,
      ),
      onChanged: onChanged,
    );
  }
}

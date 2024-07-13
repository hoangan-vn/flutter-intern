import 'dart:typed_data';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/dialogs/alert_wrapper.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/edit_profile/logic/edit_profile_state.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/user/user_repository.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class EditProfileBloc extends Cubit<EditProfileState> {
  EditProfileBloc()
      : super(EditProfileState(
            user: _initUser(), avatar: UserPrefs.I.getUserAvatar()));

  static MUser _initUser() {
    final user = UserPrefs.I.getUser();
    if (user == null) return MUser.empty();
    return user;
  }

  void initalData() {
    final user = state.user;
    if (user == MUser.empty()) {
      emit(state.copyWith(status: EditProfileStatus.fail));
    }
    emit(state.copyWith(
      name: user.name,
      height: user.height,
      weight: user.weight,
      email: user.email,
      measurementUnit: user.measurementUnit,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      initName: user.name,
    ));
  }

  void onChangeName(String name) {
    emit(state.copyWith(name: name, errorName: '', initName: ''));
  }

  Future<void> onTapDateOfBirthButton(BuildContext context) async {
    await showBoardDateTimePicker(
      context: context,
      initialDate: state.dateOfBirth,
      minimumDate: DateTime(1924, 1, 1),
      maximumDate: DateTime.now(),
      pickerType: DateTimePickerType.date,
      options: BoardDateTimeOptions(
        boardTitle: S.of(context).selectDate,
        boardTitleTextStyle:
            AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f16),
        activeColor: AppColors.primary,
      ),
      onChanged: (date) {
        _onChangeDateOfBirth(date);
      },
    );
  }

  void _onChangeDateOfBirth(DateTime date) {
    emit(state.copyWith(dateOfBirth: date));
  }

  void onChangeGender(Gender? gender) {
    emit(state.copyWith(gender: gender));
  }

  void onChangeMeasurementUnitType(MeasurementUnitType? measurementUnitType) {
    emit(state.copyWith(measurementUnit: measurementUnitType));
  }

  void onChangeHeight(double height) {
    emit(state.copyWith(height: height));
  }

  void onChangeWeight(double? weight) {
    emit(state.copyWith(weight: weight));
  }

  MUser userAfterEdit() {
    return MUser(
        id: state.user.id,
        name: state.name,
        email: state.email,
        dateOfBirth: state.dateOfBirth,
        gender: state.gender,
        measurementUnit: state.measurementUnit,
        height: state.height,
        weight: state.weight);
  }

  void showDialogUnsaved(BuildContext context) {
    XAlert.showConfirmDialog(
            S.of(context).unsavedChanges, S.of(context).doYouWantToSave,
            textNo: S.of(context).cancel, textYes: S.of(context).saveChanges)
        .then((value) {
      if (value == true) {
        saveEdittedProfile(context);
      } else {
        AppCoordinator.pop(false);
      }
    });
  }

  Future<void> saveEdittedProfile(BuildContext context) async {
    if (state.status == EditProfileStatus.loading) return;
    if (_invalidNameField(context)) {
      emit(state.copyWith(status: EditProfileStatus.fail));
    }
    XToast.showLoading();
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      MUser changedUser = userAfterEdit();
      final result =
          await GetIt.I.get<UserRepository>().upsertUser(changedUser);
      if (result.data == null) {
        emit(state.copyWith(status: EditProfileStatus.fail));
        XToast.hideLoading();
        return;
      }
      _syncAvatarToFirebase();
      _saveToSharePref(changedUser);
      emit(state.copyWith(status: EditProfileStatus.success));
      XToast.hideLoading();
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: EditProfileStatus.fail));
      XToast.hideLoading();
    }
  }

  bool _invalidNameField(BuildContext context) {
    if (StringUtils.isNullOrEmpty(state.name)) {
      emit(state.copyWith(errorName: S.of(context).thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  void _saveToSharePref(MUser changedUser) {
    UserPrefs.I.setUser(changedUser);
    UserPrefs.I.setUserAvatar(state.avatar ?? Uint8List(0));
  }

  void setAvatar(Uint8List avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  Future<void> _syncAvatarToFirebase() async {
    try {
      if (isNullOrEmpty(state.avatar) || state.avatar == Uint8List(0)) {
        await GetIt.I.get<UserRepository>().deleteImage(state.user.id);
        return;
      }
      await GetIt.I
          .get<UserRepository>()
          .addImage(state.user.id, state.avatar!);
    } catch (e) {
      xLog.e(e);
    }
  }
}

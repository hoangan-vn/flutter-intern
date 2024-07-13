import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/alert_wrapper.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/feature/setting/logic/setting_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/locator.dart';
import 'package:safebump/src/network/data/sign/sign_repository.dart';
import 'package:safebump/src/network/data/user/user_repository.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/utils.dart';

class SettingsBloc extends Cubit<SettingsState> {
  SettingsBloc() : super(SettingsState());

  void inital() {
    _getMeasurementType();
  }

  void onChangedMeasurementUnit(MeasurementUnitType type) {
    emit(state.copyWith(measurementUnitType: type));
  }

  void saveSharedPref() {
    UserPrefs.I.setBodyMeasurementUnitType(state.measurementUnitType);
  }

  void _getMeasurementType() {
    final type = UserPrefs.I.getBodyMeasurementUnitType();
    emit(state.copyWith(measurementUnitType: type));
  }

  void onTappedDeleteAccount(BuildContext context) {
    XAlert.showConfirmDialog(S.of(context).areYouSureYouWant, null,
            textNo: S.of(context).cancel,
            textYes: S.of(context).deleteMyAccount)
        .then((value) {
      if (value == true) _deleteAccount();
    });
  }

  Future<void> _deleteAccount() async {
    MUser? user = UserPrefs.I.getUser();
    if (user == null) return;
    try {
      await GetIt.I.get<UserRepository>().deleteUser(user);
      final result = await GetIt.I.get<SignRepository>().removeAccount(user);
      if (result.data != null) {
        await UserPrefs.I.clearSharedPref();
        resetSingleton();
        await GetIt.I.get<DatabaseApp>().deleteAll();
        AppCoordinator.showSignInScreen();
        return;
      }
      XToast.error(S.text.someThingWentWrong);
    } catch (e) {
      XToast.error(S.text.someThingWentWrong);
      xLog.e(e);
    }
  }
}

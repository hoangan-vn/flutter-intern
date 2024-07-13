import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/feature/profile/logic/profile_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/locator.dart';
import 'package:safebump/src/network/data/sign/sign_repository.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/utils.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc()
      : super(ProfileState(
            user: _initUser(), avatar: UserPrefs.I.getUserAvatar()));

  static MUser _initUser() {
    final user = UserPrefs.I.getUser();
    if (user == null) return MUser.empty();
    return user;
  }

  void updateProfile() {
    final memoryAvatar = UserPrefs.I.getUserAvatar();
    emit(state.copyWith(
      user: _initUser(),
      avatar: memoryAvatar,
    ));
  }

  Future<void> signOutAccount() async {
    if (state.status == ProfileScreenStatus.loading) return;
    emit(state.copyWith(status: ProfileScreenStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await GetIt.I.get<SignRepository>().logOut(state.user);
      if (result.data != null) {
        await UserPrefs.I.clearSharedPref();
        await GetIt.I.get<DatabaseApp>().deleteAll();
        resetSingleton();
        emit(state.copyWith(status: ProfileScreenStatus.success));
        return;
      }
      emit(state.copyWith(status: ProfileScreenStatus.fail));
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: ProfileScreenStatus.fail));
    }
  }
}

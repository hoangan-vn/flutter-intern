// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/sign_in/logic/sign_in_state.dart';
import 'package:safebump/src/feature/sign_in/validated/validator.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/domain_manager.dart';
import 'package:safebump/src/network/model/social_type.dart';
import 'package:safebump/src/network/model/social_user/social_user.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/utils/string_utils.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc() : super(SignInState());

  DomainManager get domain => DomainManager();

  Future loginWithEmail(BuildContext context) async {
    if (state.status == SignInStatus.signingIn) return;
    if (!isValidatedInput(context)) {
      emit(state.copyWith(status: SignInStatus.failed));
      return;
    }
    emit(state.copyWith(
      status: SignInStatus.signingIn,
      loginType: MSocialType.email,
    ));
    final email = state.email;
    final password = state.password;
    final result =
        await domain.sign.loginWithEmail(email: email!, password: password!);
    return loginDecision(context, result);
  }

  Future loginWithGoogle(BuildContext context) async {
    if (state.status == SignInStatus.signingIn) return;
    emit(state.copyWith(
      status: SignInStatus.signingIn,
      loginType: MSocialType.google,
    ));
    final result = await domain.sign.loginWithGoogle();
    return loginSocialDecision(context, result, MSocialType.google);
  }

  bool isValidatedInput(BuildContext context) {
    final emailError = Validator.emailValidated(state.email, context);
    final passError = Validator.emptyFieldValidated(state.password, context);
    emit(state.copyWith(
        emailValidated: emailError, passwordValidated: passError));
    return StringUtils.isNullOrEmpty(emailError) &&
        StringUtils.isNullOrEmpty(passError);
  }

  Future loginDecision(BuildContext context, MResult<MUser> result,
      {MSocialType? socialType}) async {
    if (result.isSuccess) {
      emit(state.copyWith(status: SignInStatus.successed));
      AppCoordinator.showSyncDataScreen();
    } else {
      emit(state.copyWith(status: SignInStatus.failed));
      XToast.error(result.error);
    }
  }

  Future loginSocialDecision(BuildContext context, MResult<MSocialUser> result,
      MSocialType socialType) async {
    if (result.isSuccess) {
      final data = result.data!;
      if (socialType == MSocialType.google) {
        connectBEWithGoogle(context, data);
      }
    } else {
      emit(state.copyWith(status: SignInStatus.failed));
    }
  }

  Future connectBEWithGoogle(BuildContext context, MSocialUser user) async {
    final result = await domain.sign.connectBEWithGoogle(user);
    return loginDecision(context, result, socialType: user.type);
  }

  void onChangedEmail(String email) {
    emit(state.copyWith(email: email, emailValidated: ''));
  }

  void onChangedPassword(String pass) {
    emit(state.copyWith(password: pass, passwordValidated: ''));
  }

  void isShowPassword() {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }
}

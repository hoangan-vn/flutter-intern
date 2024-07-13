// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:safebump/src/feature/sign_in/validated/validator.dart';
import 'package:safebump/src/feature/sign_up/logic/sign_up_state.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/domain_manager.dart';
import 'package:safebump/src/network/model/social_type.dart';
import 'package:safebump/src/network/model/social_user/social_user.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());

  DomainManager get domain => DomainManager();

  Future signupWithEmail(BuildContext context) async {
    if (state.status == SignUpStatus.signingIn) return;
    if (!isValidatedInput(context)) {
      emit(state.copyWith(status: SignUpStatus.failed));
      return;
    }
    emit(state.copyWith(
      status: SignUpStatus.signingIn,
    ));
    final email = state.email!;
    final password = state.password!;
    final name = state.name!;
    try {
      final result = await domain.sign
          .signUpWithEmail(email: email, password: password, name: name);
      signUpDecision(context, result);
    } catch (e) {
      xLog.e(e);
    }
  }

  Future signUpWithGoogle(BuildContext context) async {
    if (state.status == SignUpStatus.signingIn) return;
    emit(state.copyWith(
      status: SignUpStatus.signingIn,
      loginType: MSocialType.google,
    ));
    try {
      final result = await domain.sign.loginWithGoogle();
      return loginSocialDecision(context, result, MSocialType.google);
    } catch (e) {
      xLog.e(e);
    }
  }

  bool isValidatedInput(BuildContext context) {
    final emailError = Validator.emailValidated(state.email, context);
    final nameError = Validator.emptyFieldValidated(state.name, context);
    final passError =
        Validator.passwordCreateValidated(state.password, context);
    emit(state.copyWith(
        emailValidated: emailError,
        passwordValidated: passError,
        nameValidated: nameError));
    return StringUtils.isNullOrEmpty(emailError) &&
        StringUtils.isNullOrEmpty(passError) &&
        StringUtils.isNullOrEmpty(nameError);
  }

  Future loginSocialDecision(BuildContext context, MResult<MSocialUser> result,
      MSocialType socialType) async {
    if (result.isSuccess) {
      final data = result.data!;
      if (socialType == MSocialType.google) {
        connectBEWithGoogle(context, data);
      }
    } else {
      emit(state.copyWith(status: SignUpStatus.failed));
    }
  }

  void connectBEWithGoogle(BuildContext context, MSocialUser user) async {
    final result = await domain.sign.connectBEWithGoogle(user);
    return signUpDecision(context, result, socialType: user.type);
  }

  Future signUpDecision(BuildContext context, MResult<MUser> result,
      {MSocialType? socialType}) async {
    if (result.isSuccess) {
      emit(state.copyWith(status: SignUpStatus.successed));
      AppCoordinator.showSyncDataScreen();
    } else {
      emit(state.copyWith(status: SignUpStatus.failed));
    }
  }

  void onChangedName(String name) {
    emit(state.copyWith(name: name, nameValidated: ''));
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

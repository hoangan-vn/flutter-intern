import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/feature/forgot_password/logic/state/reset_password_state.dart';
import 'package:safebump/src/network/data/sign/sign_repository.dart';
import 'package:safebump/src/router/coordinator.dart';

class ResetPasswordBloc extends Cubit<ResetPasswordState> {
  ResetPasswordBloc(String email) : super(ResetPasswordState(email: email));

  late Timer _timer;

  @override
  Future<void> close() {
    if (!state.isTimeOut) {
      _timer.cancel();
    }
    return super.close();
  }

  void onTapResendButton() {
    if (state.isTimeOut) {
      GetIt.I<SignRepository>().forgotPassword(state.email);
      setTimeOut(false);
      _createCountdownTimer();
    }
  }

  void _createCountdownTimer() {
    int timeCounter = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(timeCounter: timeCounter));
      timeCounter--;

      if (timeCounter < 0) {
        setTimeOut(true);
        timer.cancel();
      }
    });
  }

  void setTimeOut(bool isTimeOut) {
    emit(state.copyWith(isTimeOut: isTimeOut, timeCounter: 60));
  }

  void onTapBack2LogInButton() {
    AppCoordinator.showSignInScreen();
  }
}

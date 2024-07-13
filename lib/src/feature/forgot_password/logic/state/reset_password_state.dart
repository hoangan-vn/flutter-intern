class ResetPasswordState {
  ResetPasswordState(
      {required this.email, this.isTimeOut = true, this.timeCounter = 60});

  final String email;
  final bool isTimeOut;
  final int? timeCounter;

  ResetPasswordState copyWith(
      {String? email, bool? isTimeOut, int? timeCounter}) {
    return ResetPasswordState(
        email: email ?? this.email,
        isTimeOut: isTimeOut ?? this.isTimeOut,
        timeCounter: timeCounter ?? this.timeCounter);
  }
}

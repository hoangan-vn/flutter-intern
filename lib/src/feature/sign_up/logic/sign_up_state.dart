import 'package:equatable/equatable.dart';
import 'package:safebump/src/network/model/social_type.dart';

enum SignUpStatus { init, signingIn, failed, successed }

class SignUpState with EquatableMixin {
  SignUpState(
      {this.status = SignUpStatus.init,
      this.isShowPassword = true,
      this.email,
      this.emailValidated,
      this.password,
      this.passwordValidated,
      this.name,
      this.nameValidated,
      this.loginType});

  final String? email;
  final String? emailValidated;
  final String? password;
  final String? passwordValidated;
  final String? name;
  final String? nameValidated;
  final SignUpStatus status;
  final MSocialType? loginType;
  final bool isShowPassword;

  @override
  List<Object?> get props => [
        email,
        emailValidated,
        password,
        passwordValidated,
        name,
        nameValidated,
        status,
        loginType,
        isShowPassword
      ];

  SignUpState copyWith(
      {String? email,
      String? emailValidated,
      String? password,
      String? passwordValidated,
      String? name,
      String? nameValidated,
      SignUpStatus? status,
      MSocialType? loginType,
      bool? isShowPassword}) {
    return SignUpState(
        email: email ?? this.email,
        emailValidated: emailValidated ?? this.emailValidated,
        password: password ?? this.password,
        passwordValidated: passwordValidated ?? this.passwordValidated,
        name: name ?? this.name,
        nameValidated: nameValidated ?? this.nameValidated,
        status: status ?? this.status,
        loginType: loginType ?? this.loginType,
        isShowPassword: isShowPassword ?? this.isShowPassword);
  }
}

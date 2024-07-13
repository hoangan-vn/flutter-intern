import 'package:equatable/equatable.dart';

enum EnterMailStatus { init, onProcess, fail, success }

class EnterMailState with EquatableMixin {
  EnterMailState(
      {this.status = EnterMailStatus.init, this.mail, this.mailValidated});

  final String? mail;
  final String? mailValidated;
  final EnterMailStatus status;

  @override
  List<Object?> get props => [mail, mailValidated, status];
  EnterMailState copyWith(
      {String? mail, String? mailValidated, EnterMailStatus? status}) {
    return EnterMailState(
        mail: mail ?? this.mail,
        mailValidated: mailValidated ?? this.mailValidated,
        status: status ?? this.status);
  }
}

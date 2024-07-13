import 'package:safebump/src/network/model/user/user.dart';

class AccountState {
  AccountState({this.account});

  final MUser? account;

  AccountState copyWith({MUser? account}) {
    return AccountState(account: account ?? this.account);
  }
}

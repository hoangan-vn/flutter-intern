import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/account/bloc/account_state.dart';
import 'package:safebump/src/network/model/user/user.dart';

class AccountBloc extends Cubit<AccountState> {
  AccountBloc() : super(AccountState());

  void inital(BuildContext context, MUser user) async {
    _getUser(user);
  }

  void _getUser(MUser user) async {
    
    emit(state.copyWith(account: user));
  }
}

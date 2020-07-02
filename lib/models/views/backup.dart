import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/user_state.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class BackupViewModel extends Equatable {
  final UserState user;
  final Function(VoidCallback successCb) backupWallet;

  BackupViewModel({
    this.user,
    this.backupWallet,
  });

  static BackupViewModel fromStore(Store<AppState> store) {
    return BackupViewModel(
        user: store.state.userState,
        backupWallet: (successCb) {
          store.dispatch(backupWalletCall(successCb));
        });
  }

  @override
  List<Object> get props => [user];
}

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ceu_do_mapia/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:ceu_do_mapia/models/app_state.dart';

class RecoveryViewModel {
  final Function(String, VoidCallback) generateWalletFromBackup;

  RecoveryViewModel({this.generateWalletFromBackup});

  static RecoveryViewModel fromStore(Store<AppState> store) {
    return RecoveryViewModel(
      generateWalletFromBackup: (mnemonic, VoidCallback successCallback) {
      store.dispatch(restoreWalletCall(mnemonic.split(' ').toList(), successCallback));
    });
  }
}

import 'dart:core';

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class WalletUpgradeDialogViewModel extends Equatable {
  final Function(
    VoidCallback onSuccess,
    VoidCallback onError,
  ) performWalletUpgrade;
  final bool warnSendDialogShowed;
  final bool hasUpgrade;
  final String walletAddress;
  const WalletUpgradeDialogViewModel({
    required this.performWalletUpgrade,
    required this.warnSendDialogShowed,
    required this.walletAddress,
    required this.hasUpgrade,
  });

  @override
  List<Object?> get props => [
        warnSendDialogShowed,
        hasUpgrade,
        walletAddress,
      ];

  static WalletUpgradeDialogViewModel fromStore(Store<AppState> store) {
    return WalletUpgradeDialogViewModel(
      walletAddress: store.state.userState.walletAddress,
      warnSendDialogShowed: store.state.userState.warnSendDialogShowed,
      hasUpgrade: store.state.userState.hasUpgrade,
      performWalletUpgrade: (
        VoidCallback onSuccess,
        VoidCallback onError,
      ) {
        store.dispatch(installWalletUpgrades(
          onSuccess,
          onError,
        ));
      },
    );
  }
}

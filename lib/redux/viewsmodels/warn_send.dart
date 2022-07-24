import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class WarnSendDialogViewModel extends Equatable {
  final Function(bool) updateWarnSendDialogShowed;
  final bool warnSendDialogShowed;
  final String walletAddress;
  const WarnSendDialogViewModel({
    required this.updateWarnSendDialogShowed,
    required this.warnSendDialogShowed,
    required this.walletAddress,
  });
  @override
  List<Object?> get props => [
        warnSendDialogShowed,
        walletAddress,
      ];

  static WarnSendDialogViewModel fromStore(Store<AppState> store) {
    return WarnSendDialogViewModel(
      walletAddress: store.state.userState.walletAddress,
      warnSendDialogShowed: store.state.userState.warnSendDialogShowed,
      updateWarnSendDialogShowed: (value) {
        store.dispatch(WarnSendDialogShowed(value));
      },
    );
  }
}

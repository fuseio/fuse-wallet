import 'dart:core';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class WarnSendDialogViewModel {
  final Function(bool) updateWarnSendDialogShowed;
  final bool warnSendDialogShowed;
  final String walletAddress;
  WarnSendDialogViewModel({
    required this.updateWarnSendDialogShowed,
    required this.warnSendDialogShowed,
    required this.walletAddress,
  });

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

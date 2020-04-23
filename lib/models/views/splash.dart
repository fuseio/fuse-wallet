import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_champions/redux/actions/user_actions.dart';
import 'package:local_champions/redux/actions/cash_wallet_actions.dart';
import 'package:local_champions/models/app_state.dart';
import 'package:local_champions/screens/routes.gr.dart';
import 'package:redux/redux.dart';

class SplashViewModel extends Equatable {
  final bool isProMode;
  final String privateKey;
  final String jwtToken;
  final bool isLoggedOut;
  final Function() loginAgain;
  final Function() setDeviceIdCall;
  final Function(VoidCallback successCallback) createLocalAccount;

  SplashViewModel(
      {this.privateKey,
      this.jwtToken,
      this.isLoggedOut,
      this.createLocalAccount,
      this.loginAgain,
      this.setDeviceIdCall,
      this.isProMode});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
        isProMode: store.state.userState.isProMode ?? false,
        privateKey: store.state.userState.privateKey,
        jwtToken: store.state.userState.jwtToken,
        isLoggedOut: store.state.userState.isLoggedOut ?? false,
        createLocalAccount: (VoidCallback successCallback) {
          store.dispatch(createLocalAccountCall(successCallback));
        },
        setDeviceIdCall: () {
          store.dispatch(setDeviceId(false));
        },
        loginAgain: () {
          store.dispatch(reLoginCall());
          store.dispatch(getWalletAddressessCall());
          store.dispatch(identifyCall());
          Router.navigator.pushNamedAndRemoveUntil(Router.cashHomeScreen, (Route<dynamic> route) => false);
        });
  }

  @override
  List<Object> get props => [privateKey, jwtToken, isLoggedOut, isProMode];
}

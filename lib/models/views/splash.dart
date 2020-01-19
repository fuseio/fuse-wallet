import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class SplashViewModel extends Equatable {
  final String privateKey;
  final String jwtToken;
  final bool isLoggedOut;
  final Function(String) initWeb3;
  final Function(VoidCallback successCallback) createLocalAccount;

  SplashViewModel(
      {this.privateKey,
      this.jwtToken,
      this.isLoggedOut,
      this.initWeb3,
      this.createLocalAccount});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
        privateKey: store.state.userState.privateKey,
        jwtToken: store.state.userState.jwtToken,
        isLoggedOut: store.state.userState.isLoggedOut,
        initWeb3: (privateKey) {
          store.dispatch(initWeb3Call(privateKey));
        },
        createLocalAccount: (VoidCallback successCallback) {
          store.dispatch(createLocalAccountCall(successCallback));
        }
        // accountAddress: store.state.userState.accountAddress,
        // loginRequestSuccess: store.state.userState.loginRequestSuccess,
        // loginVerifySuccess: store.state.userState.loginVerifySuccess,
        // signUp: (countryCode, phoneNumber, successCallback, failCallback) {
        //   store.dispatch(loginRequestCall(countryCode, phoneNumber, successCallback, failCallback));
        // },
        // verify: (countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback) {
        //   store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback));
        // }
        );
  }

  @override
  List<Object> get props => [privateKey, jwtToken, isLoggedOut];
}

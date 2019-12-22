import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final Function(String, String, VoidCallback, VoidCallback) signUp;
  final Function(String, String, String, String, VoidCallback, VoidCallback) verify;
  final Function(String) setPincode;

  OnboardViewModel({
    this.countryCode,
    this.phoneNumber,
    this.accountAddress,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.signUp,
    this.verify,
    this.setPincode
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    return OnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      accountAddress: store.state.userState.accountAddress,
      loginRequestSuccess: store.state.userState.loginRequestSuccess,
      loginVerifySuccess: store.state.userState.loginVerifySuccess,
      signUp: (countryCode, phoneNumber, successCallback, failCallback) {
        store.dispatch(loginRequestCall(countryCode, phoneNumber, successCallback, failCallback));
      },
      verify: (countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback) {
        store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback));
      },
      setPincode: (pincode) {
        store.dispatch(setPincodeCall(pincode));
      }
    );
  }

  bool operator ==(other) {
    if (other is OnboardViewModel) {
      if (
        countryCode == other.countryCode &&
        phoneNumber == other.phoneNumber &&
        accountAddress == other.accountAddress &&
        loginRequestSuccess == other.loginRequestSuccess &&
        loginVerifySuccess == other.loginVerifySuccess
      )
      return true;
    }
    return false;
  }

}
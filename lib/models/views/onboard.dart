import 'package:equatable/equatable.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final String verificationId;
  final String loginErrorMessage;
  final String verifyErrorMessage;
  final PhoneAuthCredential credentials;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final Function(String, String, VoidCallback, VoidCallback) signUp;
  final Function(String, String, String, String, String, VoidCallback, VoidCallback) verify;
  final Function(String) setPincode;
  final Function(String) setDisplayName;

  OnboardViewModel({
    this.countryCode,
    this.phoneNumber,
    this.accountAddress,
    this.verificationId,
    this.credentials,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.signUp,
    this.verify,
    this.setPincode,
    this.setDisplayName,
    this.loginErrorMessage,
    this.verifyErrorMessage
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    return OnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      accountAddress: store.state.userState.accountAddress,
      loginRequestSuccess: store.state.userState.loginRequestSuccess,
      loginVerifySuccess: store.state.userState.loginVerifySuccess,
      verificationId: store.state.userState.verificationId,
      credentials: store.state.userState.credentials,
      loginErrorMessage: store.state.userState.loginErrorMessage,
      verifyErrorMessage: store.state.userState.verifyErrorMessage,
      signUp: (countryCode, phoneNumber, successCallback, failCallback) {
        store.dispatch(loginRequestCall(countryCode, phoneNumber, successCallback, failCallback));
      },
      verify: (countryCode, phoneNumber, verificationCode, accountAddress, verificationId, successCallback, failCallback) {
        store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress, verificationId, successCallback, failCallback));
      },
      setPincode: (pincode) {
        store.dispatch(setPincodeCall(pincode));
      },
      setDisplayName: (displayName) {
        store.dispatch(setDisplayNameCall(displayName));
      }
    );
  }

  @override
  List<Object> get props => [
    countryCode,
    phoneNumber,
    accountAddress,
    credentials,
    loginRequestSuccess,
    loginVerifySuccess,
    verificationId,
    loginErrorMessage,
    verifyErrorMessage
  ];
}
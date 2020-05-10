import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/redux/actions/user_actions.dart';

class OnboardViewModel extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final Function(String, String, VoidCallback, VoidCallback) signUp;
  final Function(String, String, String, String, VoidCallback, VoidCallback) verify;
  final Function(String) setPincode;
  final Function(String) setDisplayName;

  OnboardViewModel({
    this.countryCode,
    this.phoneNumber,
    this.accountAddress,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.signUp,
    this.verify,
    this.setPincode,
    this.setDisplayName
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    // final PhoneVerificationCompleted verificationCompleted = (AuthCredential credentials) async {
    //   print('Got credentials: $credentials');
    //   // AuthResult authResult = await firebaseAuth.signInWithCredential(credentials);
    //   // print(authResult);
    //   store.dispatch(new SetCredentials(credentials));
    //   Router.navigator.pushNamed(Router.verifyScreen, arguments: VerifyScreenArguments(verificationId: ''));
    // };

    // final PhoneVerificationFailed verificationFailed = (AuthException authException) {
    //   print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    //   store.dispatch(new ErrorAction('Could not login $authException'));
    // };

    // final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
    //   print("PhoneCodeSent " + verificationId);
    //   store.dispatch(new SetCredentials(null));
    //   store.dispatch(SetIsLoginRequest(isLoading: false));
    //   Router.navigator.pushNamed(Router.verifyScreen, arguments: VerifyScreenArguments(verificationId: verificationId));
    // };

    // final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
    // };
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
    loginRequestSuccess,
    loginVerifySuccess
  ];
}
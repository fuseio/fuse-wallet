import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:bit2c/redux/actions/error_actions.dart';
import 'package:bit2c/screens/routes.gr.dart';
import 'package:bit2c/screens/signup/verify.dart';
import 'package:redux/redux.dart';
import 'package:bit2c/models/app_state.dart';
import 'package:bit2c/redux/actions/user_actions.dart';

class OnboardViewModel extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final String verificationId;
  final PhoneAuthCredential credentials;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final bool isLoginRequest;
  final bool isVerifyRequest;
  final Function(CountryCode, String) signUp;
  final Function(String, String, GlobalKey) verify;
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
    this.isLoginRequest,
    this.isVerifyRequest
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credentials) async {
      print('Got credentials: $credentials');
      store.dispatch(new SetCredentials(credentials));
      Router.navigator.pushNamed(Router.verifyScreen, arguments: VerifyScreenArguments(verificationId: ''));
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      store.dispatch(new ErrorAction('Could not login $authException'));
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      print("PhoneCodeSent " + verificationId);
      store.dispatch(new SetCredentials(null));
      store.dispatch(SetIsLoginRequest(isLoading: false));
      Router.navigator.pushNamed(Router.verifyScreen, arguments: VerifyScreenArguments(verificationId: verificationId));
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
    };
    return OnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      accountAddress: store.state.userState.accountAddress,
      loginRequestSuccess: store.state.userState.loginRequestSuccess,
      loginVerifySuccess: store.state.userState.loginVerifySuccess,
      verificationId: store.state.userState.verificationId,
      credentials: store.state.userState.credentials,
      isVerifyRequest: store.state.userState.isVerifyRequest,
      isLoginRequest: store.state.userState.isLoginRequest,
      signUp: (CountryCode countryCode, String phoneNumber) {
        store.dispatch(LoginRequest(
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed
        ));
      },
      verify: (verificationCode, verificationId, key) {
        store.dispatch(VerifyRequest(
          verificationCode: verificationCode,
          verificationId: verificationId,
          key: key
        ));
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
    isVerifyRequest,
    isLoginRequest
  ];
}
import 'package:country_code_picker/country_code.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/redux/actions/error_actions.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/screens/signup/verify.dart';
import 'package:digitalrand/utils/biometric_local_auth.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';

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
  final Function(BiometricAuth) setSecurityType;

  OnboardViewModel({
    this.setSecurityType,
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
      final FirebaseUser user = (await firebaseAuth.signInWithCredential(credentials)).user;
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
      final String accountAddress = store.state.userState.accountAddress;
      final String identifier = store.state.userState.identifier;
      IdTokenResult token = await user.getIdToken();
      String jwtToken = await api.login(token.token, accountAddress, identifier, appName: 'DigitalRand');
      store.dispatch(new LoginVerifySuccess(jwtToken));
      store.dispatch(SetIsVerifyRequest(isLoading: false));
      store.dispatch(segmentTrackCall("Wallet: verified phone number"));
      Router.navigator.pushReplacementNamed(Router.userNameScreen);
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
        store.dispatch(SetPincodeSuccess(pincode));
      },
      setDisplayName: (displayName) {
        store.dispatch(setDisplayNameCall(displayName));
      },
      setSecurityType: (biometricAuth) {
      store.dispatch(SetSecurityType(biometricAuth: biometricAuth));
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
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

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
  final Function(String, String) verify;
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
      store.dispatch(new SetCredentials(credentials));
      final FirebaseUser user = (await firebaseAuth.signInWithCredential(credentials)).user;
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
      final String accountAddress = store.state.userState.accountAddress;
      final String identifier = store.state.userState.identifier;
      IdTokenResult token = await user.getIdToken();
      String jwtToken = await api.login(token.token, accountAddress, identifier);
      store.dispatch(new LoginVerifySuccess(jwtToken));
      store.dispatch(SetIsVerifyRequest(isLoading: false));
      store.dispatch(segmentTrackCall("Wallet: verified phone number"));
      ExtendedNavigator.root.push(Routes.userNameScreen);
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      store.dispatch(new ErrorAction('Could not login $authException'));
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      print("PhoneCodeSent " + verificationId);
      store.dispatch(new SetCredentials(null));
      store.dispatch(SetIsLoginRequest(isLoading: false));
      ExtendedNavigator.root.push(Routes.verifyScreen, arguments: VerifyScreenArguments(verificationId: verificationId));
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
      verify: (verificationCode, verificationId) {
        store.dispatch(VerifyRequest(
          verificationCode: verificationCode,
          verificationId: verificationId,
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
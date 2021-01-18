// import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
// import 'package:fusecash/redux/actions/error_actions.dart';
// import 'package:fusecash/redux/state/store.dart';
// import 'package:fusecash/features/routes.gr.dart';
// import 'package:fusecash/services.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final String verificationId;
  final PhoneAuthCredential credentials;
  final bool isLoginRequest;
  final bool isVerifyRequest;
  final Function(CountryCode, PhoneNumber) signUp;
  final Function(String code) verify;
  final Function(String) setPincode;
  final Function(String) setDisplayName;
  final Function(BiometricAuth) setSecurityType;
  final dynamic verifyErrorMessage;
  final dynamic signupErrorMessage;
  final Function resetErrors;

  OnboardViewModel(
      {this.setSecurityType,
      this.countryCode,
      this.phoneNumber,
      this.accountAddress,
      this.verificationId,
      this.credentials,
      this.signUp,
      this.verify,
      this.setPincode,
      this.setDisplayName,
      this.isLoginRequest,
      this.isVerifyRequest,
      this.verifyErrorMessage,
      this.signupErrorMessage,
      this.resetErrors});

  static OnboardViewModel fromStore(Store<AppState> store) {
    return OnboardViewModel(
        countryCode: store.state.userState.countryCode,
        phoneNumber: store.state.userState.phoneNumber,
        accountAddress: store.state.userState.accountAddress,
        verificationId: store.state.userState.verificationId,
        credentials: store.state.userState.credentials,
        isVerifyRequest: store.state.userState.isVerifyRequest,
        isLoginRequest: store.state.userState.isLoginRequest,
        signupErrorMessage: store.state.userState.signupErrorMessage,
        verifyErrorMessage: store.state.userState.verifyErrorMessage,
        signUp: (CountryCode countryCode, PhoneNumber phoneNumber) {
          store.dispatch(loginHandler(countryCode, phoneNumber));
        },
        verify: (String verificationCode) async {
          store.dispatch(verifyHandler(verificationCode));
        },
        setPincode: (pincode) {
          store.dispatch(SetPincodeSuccess(pincode));
        },
        setDisplayName: (displayName) {
          store.dispatch(SetDisplayName(displayName));
          store.dispatch(segmentTrackCall("Wallet: display name added"));
        },
        setSecurityType: (biometricAuth) {
          store.dispatch(SetSecurityType(biometricAuth: biometricAuth));
        },
        resetErrors: () {
          store.dispatch(SetIsVerifyRequest(message: '', isLoading: false));
          store.dispatch(SetIsLoginRequest(message: '', isLoading: false));
        });
  }

  @override
  List<Object> get props => [
        countryCode,
        phoneNumber,
        accountAddress,
        credentials,
        verificationId,
        isVerifyRequest,
        isLoginRequest,
        verifyErrorMessage,
        signupErrorMessage
      ];
}

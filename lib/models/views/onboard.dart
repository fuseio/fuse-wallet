import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel {
  final String countryCode;
  final String phoneNumber;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final Function(String, String) signUp;
  final Function(String, String, String) verify;

  OnboardViewModel({
    this.countryCode,
    this.phoneNumber,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.signUp,
    this.verify
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    return OnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      loginRequestSuccess: store.state.userState.loginRequestSuccess,
      loginVerifySuccess: store.state.userState.loginVerifySuccess,
      signUp: (countryCode, phoneNumber) {
        store.dispatch(loginRequestCall(countryCode, phoneNumber));
      },
      verify: (countryCode, phoneNumber, verificationCode) {
        store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode));
      }
    );
  }

}
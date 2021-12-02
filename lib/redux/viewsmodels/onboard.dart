import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/actions/user_actions.dart';
import 'package:supervecina/models/user_state.dart';

class VerifyOnboardViewModel extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String? verificationId;
  final PhoneAuthCredential? credentials;
  final Function(
    String code,
    Function onSuccess,
    Function(dynamic error) onError,
  ) verify;

  VerifyOnboardViewModel({
    required this.countryCode,
    required this.phoneNumber,
    required this.verificationId,
    required this.credentials,
    required this.verify,
  });

  static VerifyOnboardViewModel fromStore(Store<AppState> store) {
    UserState userState = store.state.userState;
    return VerifyOnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      verificationId: store.state.userState.verificationId,
      credentials: userState.credentials,
      verify: (
        String verificationCode,
        Function onSuccess,
        Function(dynamic error) onError,
      ) {
        store.dispatch(
          verifyHandler(
            verificationCode,
            onSuccess,
            onError,
          ),
        );
      },
    );
  }

  @override
  List<Object?> get props => [
        countryCode,
        phoneNumber,
      ];
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:sentry_flutter/sentry_flutter.dart' show Sentry;

class FirebaseStrategy implements IOnBoardStrategy {
  final strategy;
  FirebaseStrategy({this.strategy = OnboardStrategy.firebase});

  @override
  Future login(store, phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted = (
      PhoneAuthCredential credentials,
    ) async {
      store.dispatch(SetCredentials(credentials));
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credentials,
      );
      final User? user = userCredential.user;
      final User currentUser = firebaseAuth.currentUser!;
      assert(user?.uid == currentUser.uid);
      final String accountAddress = store.state.userState.accountAddress;
      final String identifier = store.state.userState.identifier;
      String token = await user!.getIdToken();
      String jwtToken = await api.loginWithFirebase(
        token,
        accountAddress,
        identifier,
        appName: Strings.APP_NAME,
      );
      Segment.track(
        eventName: 'Sign up: VerificationCode_NextBtn_Press',
      );
      store.dispatch(SetIsVerifyRequest(isLoading: false));
      log.info('jwtToken $jwtToken');
      store.dispatch(LoginVerifySuccess(jwtToken));
      rootRouter.push(UserNameScreen());
    };

    final PhoneVerificationFailed verificationFailed = (
      FirebaseAuthException authException,
    ) async {
      log.info(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      store.dispatch(
        SetIsLoginRequest(
          isLoading: false,
          message: authException.message,
        ),
      );

      store.dispatch(
        SetIsVerifyRequest(
          isLoading: false,
          message: authException.message,
        ),
      );
      await Sentry.captureException(
        authException,
        stackTrace: authException.stackTrace,
        hint:
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
      );
    };

    final PhoneCodeSent codeSent = (
      String verificationId, [
      int? forceResendingToken,
    ]) {
      log.info("PhoneCodeSent " + verificationId);
      store.dispatch(SetIsLoginRequest(isLoading: false));
      store.dispatch(SetCredentials(null));
      store.dispatch(SetVerificationId(verificationId));
      rootRouter.push(VerifyPhoneNumber(verificationId: verificationId));
    };

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
    );
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    store.dispatch(setDeviceId());
    store.dispatch(SetIsVerifyRequest(isLoading: true));
    PhoneAuthCredential? credential = store.state.userState.credentials;
    final String verificationId = store.state.userState.verificationId;
    if (credential == null) {
      credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
    }
    UserCredential userCredential = await firebaseAuth.signInWithCredential(
      credential,
    );
    final User? currentUser = firebaseAuth.currentUser;
    assert(userCredential.user?.uid == currentUser?.uid);
    final String accountAddress = store.state.userState.accountAddress;
    final String identifier = store.state.userState.identifier;
    String token = await userCredential.user!.getIdToken();
    final String jwtToken = await api.loginWithFirebase(
      token,
      accountAddress,
      identifier,
      appName: Strings.APP_NAME,
    );
    onSuccess(jwtToken);
  }
}

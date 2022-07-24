import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/onboard/base_strategy.dart';

class FirebaseStrategy implements IOnBoardStrategy {
  @override
  OnboardStrategy strategy;
  FirebaseStrategy({this.strategy = OnboardStrategy.firebase});

  @override
  Future login(
    store,
    phoneNumber,
    VoidCallback onSuccess,
    Function(dynamic error) onError,
  ) async {
    void verificationCompleted(
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
      try {
        String jwtToken = await chargeApi.loginWithFirebase(
          token,
          accountAddress,
          identifier,
        );
        Analytics.track(
          eventName: AnalyticsEvents.verify,
          properties: {
            AnalyticsProps.status: AnalyticsProps.success,
          },
        );
        onSuccess();
        store.dispatch(LoginVerifySuccess(jwtToken));
        rootRouter.push(const UserNameRoute());
      } catch (e) {
        onError(e.toString());
      }
    }

    void verificationFailed(FirebaseAuthException authException) async {
      log.info(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      onError(authException.message);
    }

    void codeSent(
      String verificationId, [
      int? forceResendingToken,
    ]) {
      log.info("PhoneCodeSent verificationId: $verificationId");
      onSuccess();
      store.dispatch(SetCredentials(null));
      store.dispatch(SetVerificationId(verificationId));
      rootRouter.push(VerifyPhoneNumberRoute(verificationId: verificationId));
    }

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
    );
  }

  @override
  Future verify(
    store,
    verificationCode,
    onSuccess,
  ) async {
    PhoneAuthCredential? credential = store.state.userState.credentials;
    final String verificationId = store.state.userState.verificationId;
    credential ??= PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );
    UserCredential userCredential = await firebaseAuth.signInWithCredential(
      credential,
    );
    final User? currentUser = firebaseAuth.currentUser;
    assert(userCredential.user?.uid == currentUser?.uid);
    final String accountAddress = store.state.userState.accountAddress;
    final String identifier = store.state.userState.identifier;
    String token = await userCredential.user!.getIdToken();
    final String jwtToken = await chargeApi.loginWithFirebase(
      token,
      accountAddress,
      identifier,
    );
    onSuccess(jwtToken);
  }
}

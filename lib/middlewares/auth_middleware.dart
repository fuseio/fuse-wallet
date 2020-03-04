// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/keys.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  // final checkIfUserExists = _createCheckIfUserExistsMiddleware();
  // final resgiterUser = _createRegisterUserMiddleware();
  final sendOTP = _createSendOTPMiddleware();
  final verifyPhoneNumber = _createVerifyPhoneNumberMiddleware();
  // final logOut = _createLogOutMiddleware();

  return [
    // TypedMiddleware<AppState, CheckIfUserExists>(checkIfUserExists),
    // TypedMiddleware<AppState, RegisterUser>(resgiterUser),
    TypedMiddleware<AppState, LoginRequestSuccess>(sendOTP),
    TypedMiddleware<AppState, VerifyOTP>(verifyPhoneNumber),
    // TypedMiddleware<AppState, LogOut>(logOut),
  ];
}

Middleware<AppState> _createSendOTPMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is LoginRequestSuccess) {
      try {
        // store.dispatch(StartLoading());
        String phone = formatPhoneNumber(action.phoneNumber, action.countryCode);
        await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          codeAutoRetrievalTimeout: action.codeAutoRetrievalTimeout,
          codeSent: action.codeSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: action.verificationCompleted,
          verificationFailed: action.verificationFailed
        );
      }
      catch (error) {
        // store.dispatch(StopLoading());
        print(error);
      }
    }
    next(action);
  };
}

Middleware<AppState> _createVerifyPhoneNumberMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is VerifyOTP) {
      try {
        // store.dispatch(StartLoading());
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: action.verificationId,
          smsCode: action.otp,
        );
        final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await firebaseAuth.currentUser();
        assert(user.uid == currentUser.uid);
        Keys.navigatorKey.currentState.pushReplacementNamed('/UserName');
        // store.dispatch(StopLoading());
        // store.dispatch(LogInSuccessful(user: user));
      }
      catch (error) {
        // store.dispatch(StopLoading());
        // store.dispatch(LogInFail(error: error));
        action.key.currentState.showSnackBar(SnackBar(
          content: Text("Verification failed.")
        ));
      }
    }
    next(action);
  };
}

// Middleware<AppState> _createLogOutMiddleware() {
//   return (Store store, action, NextDispatcher next) async {
// 		final FirebaseAuth _auth = FirebaseAuth.instance;
//     try {
//       await _auth.signOut();
//       print('logging out...');
//       Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.authScreen, (Route<dynamic> route) => false);
//       store.dispatch(LogOutSuccessful());
//     } catch (error) {
//       print(error);
//     }
// 	};
// }
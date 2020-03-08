import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final loginRequest = _createLoginRequestMiddleware();
  final verifyRequest = _createVerifyPhoneNumberMiddleware();

  return [
    TypedMiddleware<AppState, LoginRequest>(loginRequest),
    TypedMiddleware<AppState, VerifyRequest>(verifyRequest),
  ];
}

Middleware<AppState> _createLoginRequestMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final logger = await AppFactory().getLogger('action');
    if (action is LoginRequest) {
      try {
        store.dispatch(SetIsLoginRequest(isLoading: true));
        String phone = formatPhoneNumber(action.phoneNumber, action.countryCode);
        await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          codeAutoRetrievalTimeout: action.codeAutoRetrievalTimeout,
          codeSent: action.codeSent,
          timeout: Duration(minutes: 2),
          verificationCompleted: action.verificationCompleted,
          verificationFailed: action.verificationFailed
        );
        store.dispatch(new LoginRequestSuccess(action.countryCode, action.phoneNumber, "", ""));
        store.dispatch(segmentAliasCall(phone));
        store.dispatch(segmentTrackCall("Wallet: user insert his phone number", properties: new Map<String, dynamic>.from({ "Phone number": phone })));
      }
      catch (e, s) {
        store.dispatch(SetIsLoginRequest(isLoading: false));
        logger.severe('ERROR - LoginRequest $e');
        await AppFactory().reportError(e, s);
        store.dispatch(new ErrorAction(e.toString()));
        store.dispatch(segmentTrackCall("ERROR in LoginRequest", properties: new Map.from({ "error": e.toString() })));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createVerifyPhoneNumberMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final logger = await AppFactory().getLogger('action');
    if (action is VerifyRequest) {
      try {
        store.dispatch(SetIsVerifyRequest(isLoading: true));
        PhoneAuthCredential credential = store.state.userState.credentials;
        if (credential == null) {
          credential = PhoneAuthProvider.getCredential(
            verificationId: action.verificationId,
            smsCode: action.verificationCode,
          );
        }
        final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await firebaseAuth.currentUser();
        assert(user.uid == currentUser.uid);
        String accountAddress = store.state.userState.accountAddress;
        IdTokenResult token = await user.getIdToken();
        String jwtToken = await api.login(token.token, accountAddress);
        store.dispatch(new LoginVerifySuccess(jwtToken));
        store.dispatch(SetIsVerifyRequest(isLoading: false));
        store.dispatch(segmentTrackCall("Wallet: verified phone number"));
        Router.navigator.pushReplacementNamed(Router.userNameScreen);
      }
      catch (e, s) {
        store.dispatch(SetIsVerifyRequest(isLoading: false));
        logger.severe('ERROR - Verification failed $e');
        await AppFactory().reportError(e, s);
        store.dispatch(new ErrorAction(e.toString()));
        store.dispatch(segmentTrackCall("ERROR in VerifyRequest", properties: new Map.from({ "error": e.toString() })));
      }
    }
    next(action);
  };
}
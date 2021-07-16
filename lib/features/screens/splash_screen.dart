import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';

class SplashScreen extends StatefulWidget {
  final void Function(bool isLoggedIn)? onLoginResult;
  const SplashScreen({
    Key? key,
    this.onLoginResult,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Flushbar flush;

  onInit(Store<AppState> store) async {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    if (privateKey.isEmpty || jwtToken.isEmpty || isLoggedOut) {
      await Segment.setContext({});
      context.router.replaceAll([OnBoardScreen()]);
      widget.onLoginResult?.call(false);
    } else {
      UserState userState = store.state.userState;
      if (userState.authType != BiometricAuth.none) {
        Segment.track(
          eventName: 'Session Start: Authentication request for existed user',
        );
        store.dispatch(getWalletAddressesCall());
        store.dispatch(identifyCall());
        store.dispatch(loadContacts());
        store.dispatch(getRewardData());
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
      if (BiometricAuth.faceID == userState.authType ||
          BiometricAuth.touchID == userState.authType) {
        await _showLocalAuthPopup(
          BiometricUtils.getBiometricString(
            context,
            userState.authType,
          ),
        );
        widget.onLoginResult?.call(true);
      } else if (userState.authType == BiometricAuth.pincode) {
        context.router.replaceAll([PinCodeScreen()]);
        widget.onLoginResult?.call(true);
      } else {
        context.router.replaceAll([MainScreen()]);
        widget.onLoginResult?.call(true);
      }
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message:
          '${I10n.of(context).please_use} $biometric ${I10n.of(context).to_unlock}',
      stickyAuth: true,
      callback: (bool result) {
        if (result) {
          Segment.track(
            eventName: 'Session Start: Authentication success',
          );
          context.router.replaceAll([MainScreen()]);
          widget.onLoginResult?.call(true);
        } else {
          flush = Flushbar<bool>(
            title: I10n.of(context).auth_failed_title,
            message: I10n.of(context).auth_failed_message,
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            mainButton: TextButton(
              onPressed: () {
                flush.dismiss(true);
              },
              child: Text(
                I10n.of(context).try_again,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )..show(context).then(
              (result) async {
                if (result == true) {
                  BiometricAuth _biometricType =
                      await BiometricUtils.getAvailableBiometrics();
                  await _showLocalAuthPopup(
                    BiometricUtils.getBiometricString(
                      context,
                      _biometricType,
                    ),
                  );
                  widget.onLoginResult?.call(true);
                }
              },
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LockScreenViewModel>(
      distinct: true,
      onInit: onInit,
      converter: LockScreenViewModel.fromStore,
      builder: (_, viewModel) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: SvgPicture.asset(
              'assets/images/fusecash.svg',
              width: 140,
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/splash.png',
                              width: 85,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

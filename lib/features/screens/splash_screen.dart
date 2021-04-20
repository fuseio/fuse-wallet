import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BiometricAuth _biometricType;
  Flushbar flush;

  @override
  void initState() {
    super.initState();
    _checkBiometrical();
  }

  Future<void> _checkBiometrical() async {
    _biometricType = await BiometricUtils.getAvailableBiometrics();
    if (_biometricType != BiometricAuth.none) {
      setState(() {
        _biometricType = _biometricType;
      });
    }
  }

  onInit(Store<AppState> store) async {
    String privateKey = store?.state?.userState?.privateKey ?? '';
    String jwtToken = store?.state?.userState?.jwtToken ?? '';
    bool isLoggedOut = store?.state?.userState?.isLoggedOut ?? false;
    if (privateKey.isEmpty || jwtToken.isEmpty || isLoggedOut) {
      ExtendedNavigator.root.replace(Routes.onBoardScreen);
    } else {
      UserState userState = store.state.userState;
      if (userState?.authType != BiometricAuth.none) {
        store.dispatch(getWalletAddressesCall());
        store.dispatch(identifyCall());
        store.dispatch(loadContacts());
      }
      if (BiometricAuth.faceID == userState.authType ||
          BiometricAuth.touchID == userState.authType) {
        await _showLocalAuthPopup(
          BiometricUtils.getBiometricString(_biometricType),
        );
      } else if (userState?.authType == BiometricAuth.pincode) {
        ExtendedNavigator.root.replace(Routes.pinCodeScreen);
      } else {
        ExtendedNavigator.root.replace(Routes.homeScreen);
      }
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message: 'Please use $biometric to unlock!',
      stickyAuth: true,
      callback: (bool result) {
        if (result) {
          ExtendedNavigator.root.replace(Routes.homeScreen);
        } else {
          flush = Flushbar<bool>(
            title: I18n.of(context).auth_failed_title,
            message: I18n.of(context).auth_failed_message,
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            mainButton: FlatButton(
              onPressed: () async {
                flush.dismiss(true);
              },
              child: Text(
                I18n.of(context).try_again,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )..show(context).then(
              (result) async {
                if (result) {
                  await _showLocalAuthPopup(
                    BiometricUtils.getBiometricString(_biometricType),
                  );
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
              // height: 28,
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

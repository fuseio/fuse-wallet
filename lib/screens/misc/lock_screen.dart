import 'package:auto_route/auto_route.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/views/backup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  BiometricAuth _biometricType;
  @override
  void initState() {
    super.initState();
    _checkBiometricable();
  }

  Future<void> _checkBiometricable() async {
    _biometricType = await BiometricUtils.getAvailableBiometrics();
    if (_biometricType != BiometricAuth.none) {
      setState(() {
        _biometricType = _biometricType;
      });
    }
  }

  _handleLocalAuh(store) async {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    if (privateKey.isEmpty || jwtToken.isEmpty || isLoggedOut) {
      ExtendedNavigator.root.pushReplacementNamed(Routes.splashScreen);
    } else {
      UserState userState = store.state.userState;
      if (BiometricAuth.faceID == userState.authType ||
          BiometricAuth.touchID == userState.authType) {
        await _showLocalAuthPopup(
          BiometricUtils.getBiometricString(_biometricType),
        );
      } else if (userState.authType == BiometricAuth.pincode) {
        ExtendedNavigator.root.pushReplacementNamed(Routes.pincode);
      } else {
        ExtendedNavigator.root.pushReplacementNamed(Routes.homePage);
      }
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message: 'Please use $biometric to unlock!',
      stickyAuth: true,
      callback: (bool result) {
        if (result) {
          ExtendedNavigator.root.pushReplacementNamed(Routes.homePage);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          ExtendedNavigator.root.pop<bool>(false);
          return false;
        },
        child: StoreConnector<AppState, LockScreenViewModel>(
            distinct: true,
            onInit: (store) {
              _handleLocalAuh(store);
            },
            converter: LockScreenViewModel.fromStore,
            builder: (_, viewModel) {
              return Scaffold(
                  body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFB1FDC0),
                    Color(0xFFE6FD99),
                    Color(0xFFFEFD86)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset('assets/images/fuse_logo.svg',
                                    width: 78,
                                    height: 25,
                                    color: Color(0xFF656565)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }));
  }
}

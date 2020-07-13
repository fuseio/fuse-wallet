import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/models/views/backup.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/user_state.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/utils/biometric_local_auth.dart';

class LockScreen extends StatefulWidget {
  final Store<AppState> store;
  LockScreen({this.store});
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
    UserState userState = store.state.userState;
    if (BiometricAuth.faceID == userState.authType ||
        BiometricAuth.touchID == userState.authType) {
      await _showLocalAuthPopup(
        BiometricUtils.getBiometricString(_biometricType),
      );
    } else if (userState.authType == BiometricAuth.pincode) {
      Router.navigator.pushNamedAndRemoveUntil(
          Router.pincode, (Route<dynamic> route) => false);
    } else {
      Router.navigator.pushNamedAndRemoveUntil(
          Router.cashHomeScreen, (Route<dynamic> route) => false);
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message: 'Please use $biometric to unlock!',
      stickyAuth: true,
      callback: (bool result) {
        if (result) {
          Router.navigator.pushNamedAndRemoveUntil(
              Router.cashHomeScreen, (Route<dynamic> route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: new StoreConnector<AppState, LockScreenViewModel>(
            distinct: true,
            onInit: (store) async {
              await _handleLocalAuh(store);
            },
            converter: LockScreenViewModel.fromStore,
            builder: (_, viewModel) {
              return Scaffold(
                  body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF2256B9), Color(0xFF0233A4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
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
                                Image.asset(
                                  'assets/images/digitalrand_logo.png',
                                  width: 135,
                                  height: 21,
                                )
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

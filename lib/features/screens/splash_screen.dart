import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';

class SplashPage extends StatefulWidget {
  final void Function(bool isLoggedIn)? onLoginResult;
  const SplashPage({
    Key? key,
    this.onLoginResult,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Flushbar flush;
  void onInit(Store<AppState> store) async {
    UserState userState = store.state.userState;
    String privateKey = userState.privateKey;
    String jwtToken = userState.jwtToken;
    bool isLoggedOut = userState.isLoggedOut;
    if (privateKey.isEmpty || jwtToken.isEmpty || isLoggedOut) {
      context.router.replaceAll([const OnBoardingRoute()]);
      widget.onLoginResult?.call(false);
    } else {
      if (userState.authType != BiometricAuth.none) {
        store.dispatch(web3Init());
        store.dispatch(getWalletAddressesCall());
        store.dispatch(identifyCall());
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
        context.router.replaceAll([const PinCodeRoute()]);
        widget.onLoginResult?.call(true);
      } else {
        context.router.replaceAll([const MainRoute()]);
        widget.onLoginResult?.call(true);
      }
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message:
          '${I10n.of(context).please_use} $biometric ${I10n.of(context).to_unlock}',
      callback: (bool result) {
        if (result) {
          context.router.replaceAll([const MainRoute()]);
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          )..show(context).then(
              (result) {
                if (result != null) {
                  if (result == true) {
                    BiometricUtils.getAvailableBiometrics().then(
                      (BiometricAuth biometricType) async {
                        await _showLocalAuthPopup(
                          BiometricUtils.getBiometricString(
                            context,
                            biometricType,
                          ),
                        );
                        widget.onLoginResult?.call(true);
                      },
                    );
                  }
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
          // appBar: AppBar(
          //   elevation: 0,
          //   shadowColor: Theme.of(context).colorScheme.primary,
          //   backgroundColor: Theme.of(context).colorScheme.primary,
          //   centerTitle: true,
          //   title: SvgPicture.asset(
          //     'assets/images/fusecash.svg',
          //     width: 140,
          //   ),
          // ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/pincode_logo.png',
                              width: 71,
                              height: 61,
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/onboard/dialogs/warn_before_recreate.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/transparent_button.dart';

class CreateWallet extends StatefulWidget {
  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  bool isPrimaryPreloading = false;
  bool isTransparentPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                PrimaryButton(
                  disabled: isPrimaryPreloading,
                  label: viewModel.isLoggedOut
                      ? I10n.of(context).login
                      : I10n.of(context).create_new_wallet,
                  onPressed: () async {
                    if (viewModel.isLoggedOut) {
                      viewModel.loginAgain();
                      if (ExtendedNavigator.root.canPop()) {
                        ExtendedNavigator.root.popUntilRoot();
                      }
                      ExtendedNavigator.root.replace(Routes.homeScreen);
                    } else {
                      setState(() {
                        isPrimaryPreloading = true;
                      });
                      viewModel.createLocalAccount(() {
                        setState(() {
                          isPrimaryPreloading = false;
                        });
                        ExtendedNavigator.root.pushSignUpScreen();
                      }, () {
                        setState(() {
                          isPrimaryPreloading = false;
                        });
                      });
                    }
                  },
                  preload: isPrimaryPreloading,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: viewModel.isLoggedOut
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TransparentButton(
                                  fontSize: 14,
                                  label: I10n.of(context).restore_backup,
                                  onPressed: () async {
                                    ExtendedNavigator.root.pushRecoveryPage();
                                  }),
                              Text(
                                I10n.of(context).or,
                                style: TextStyle(
                                  color: Color(0xFFB2B2B2),
                                ),
                              ),
                              TransparentButton(
                                  fontSize: 14,
                                  label: I10n.of(context).create__wallet,
                                  onPressed: () async {
                                    bool result = await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          WarnBeforeReCreation(),
                                    );
                                    if (result) {
                                      setState(() {
                                        isTransparentPreloading = true;
                                      });
                                      viewModel.createLocalAccount(() {
                                        ExtendedNavigator.root
                                            .pushSignUpScreen();
                                      }, () {
                                        setState(() {
                                          isTransparentPreloading = false;
                                        });
                                      });
                                    }
                                  },
                                  preload: isTransparentPreloading)
                            ],
                          )
                        : TransparentButton(
                            fontSize: 20,
                            label: I10n.of(context).restore_from_backup,
                            onPressed: () async {
                              ExtendedNavigator.root.pushRecoveryPage();
                            }))
              ],
            ),
          );
        });
  }
}

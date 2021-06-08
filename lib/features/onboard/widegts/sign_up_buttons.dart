import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/onboard/dialogs/warn_before_recreate.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/show_up.dart';
import 'package:fusecash/widgets/transparent_button.dart';

class SignUpButtons extends StatefulWidget {
  @override
  _SignUpButtonsState createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  bool isPrimaryPreloading = false;
  bool isTransparentPreloading = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
      distinct: true,
      converter: SplashViewModel.fromStore,
      builder: (_, viewModel) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned.fill(
                top: 400,
                child: ShowUp(
                  delay: 800,
                  child: Text(
                    I10n.of(context).lets_start,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  PrimaryButton(
                    disabled: isPrimaryPreloading,
                    preload: isPrimaryPreloading,
                    label: viewModel.isLoggedOut
                        ? I10n.of(context).login
                        : I10n.of(context).create_new_wallet,
                    onPressed: () {
                      if (viewModel.isLoggedOut) {
                        viewModel.loginAgain();
                        // if (ExtendedNavigator.root.canPop()) {
                        //   ExtendedNavigator.root.popUntilRoot();
                        // }
                        // ExtendedNavigator.root.replace(Routes.homeScreen);
                      } else {
                        setState(() {
                          isPrimaryPreloading = true;
                        });
                        viewModel.createLocalAccount(() {
                          setState(() {
                            isPrimaryPreloading = false;
                          });
                          // ExtendedNavigator.root.pushSignUpScreen();
                        }, () {
                          setState(() {
                            isPrimaryPreloading = false;
                          });
                        });
                      }
                    },
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
                                onPressed: () {
                                  // ExtendedNavigator.root.pushRecoveryPage();
                                  Segment.track(
                                    eventName:
                                        'Existing User: Restore wallet from backup',
                                  );
                                  // ExtendedNavigator.root
                                  //     .pushRestoreFromBackupScreen();
                                },
                              ),
                              Text(
                                I10n.of(context).or,
                                style: TextStyle(
                                  color: Color(0xFFB2B2B2),
                                ),
                              ),
                              TransparentButton(
                                fontSize: 14,
                                label: I10n.of(context).create__wallet,
                                preload: isTransparentPreloading,
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
                                      // ExtendedNavigator.root.pushSignUpScreen();
                                    }, () {
                                      setState(() {
                                        isTransparentPreloading = false;
                                      });
                                    });
                                  }
                                },
                              )
                            ],
                          )
                        : TransparentButton(
                            fontSize: 20,
                            label: I10n.of(context).restore_from_backup,
                            onPressed: () {
                              // ExtendedNavigator.root.pushRecoveryPage();
                              Segment.track(
                                eventName:
                                    'Existing User: Restore wallet from backup',
                              );
                              // ExtendedNavigator.root
                              //     .pushRestoreFromBackupScreen();
                            },
                          ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

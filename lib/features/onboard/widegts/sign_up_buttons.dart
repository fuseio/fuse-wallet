import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/onboard/dialogs/warn_before_recreate.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/primary_button.dart';
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
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            PrimaryButton(
              disabled: isPrimaryPreloading,
              preload: isPrimaryPreloading,
              label: viewModel.isLoggedOut
                  ? I18n.of(context).login
                  : I18n.of(context).create_new_wallet,
              onPressed: () {
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
                          label: I18n.of(context).restore_backup,
                          onPressed: () {
                            ExtendedNavigator.root.pushRecoveryPage();
                          },
                        ),
                        Text(
                          I18n.of(context).or,
                          style: TextStyle(
                            color: Color(0xFFB2B2B2),
                          ),
                        ),
                        TransparentButton(
                          fontSize: 14,
                          label: I18n.of(context).create__wallet,
                          preload: isTransparentPreloading,
                          onPressed: () async {
                            bool result = await showDialog(
                              context: context,
                              builder: (context) => WarnBeforeReCreation(),
                            );
                            if (result) {
                              setState(() {
                                isTransparentPreloading = true;
                              });
                              viewModel.createLocalAccount(() {
                                ExtendedNavigator.root.pushSignUpScreen();
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
                      label: I18n.of(context).restore_from_backup,
                      onPressed: () {
                        ExtendedNavigator.root.pushRecoveryPage();
                      },
                    ),
            )
          ],
        );
      },
    );
  }
}

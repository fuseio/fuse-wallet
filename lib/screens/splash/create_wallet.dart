import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/views/splash.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/widgets/transparent_button.dart';
import 'package:paywise/screens/routes.gr.dart';

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
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/paywise.jpg', width: 350, height: 550,),
              PrimaryButton(
                fontSize: 16,
                labelFontWeight: FontWeight.normal,
                label: viewModel.isLoggedOut
                    ? I18n.of(context).login
                    : I18n.of(context).create_new_wallet,
                onPressed: () async {
                  if (viewModel.isLoggedOut) {
                    viewModel.loginAgain();
                  } else {
                    viewModel.createLocalAccount(() {
                      setState(() {
                        isPrimaryPreloading = false;
                      });
                      Router.navigator.pushNamed(Router.signupScreen);
                    });
                    setState(() {
                      isPrimaryPreloading = true;
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
                                label: I18n.of(context).restore_backup,
                                onPressed: () async {
                                  Router.navigator.pushNamed(Router.recoveryPage);
                                }),
                            Text(
                              I18n.of(context).or,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            TransparentButton(
                                fontSize: 14,
                                label: I18n.of(context).create__wallet,
                                onPressed: () async {
                                  viewModel.createLocalAccount(() {
                                    setState(() {
                                      isTransparentPreloading = false;
                                    });
                                    Router.navigator.pushNamed(Router.signupScreen);
                                  });
                                  setState(() {
                                    isTransparentPreloading = true;
                                  });
                                },
                                preload: isTransparentPreloading)
                          ],
                        )
                      : TransparentButton(
                          fontSize: 16,
                          label: I18n.of(context).restore_from_backup,
                          onPressed: () async {
                            Router.navigator.pushNamed(Router.recoveryPage);
                          }))
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/splash.dart';
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
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return SizedBox(
            height: 180,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 00),
                  child: PrimaryButton(
                    fontSize: 16,
                    labelFontWeight: FontWeight.normal,
                    label:
                        viewModel.isLoggedOut ? I18n.of(context).login : I18n.of(context).create_new_wallet,
                    onPressed: () {
                      if (viewModel.isLoggedOut) {
                        viewModel.loginAgain();
                        viewModel.initWeb3(viewModel.privateKey);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                        Navigator.pushNamed(context, '/Cash');
                      } else {
                        viewModel.createLocalAccount(() {
                          setState(() {
                            isPrimaryPreloading = false;
                          });
                          Navigator.pushNamed(context, '/Signup');
                        });
                        setState(() {
                          isPrimaryPreloading = true;
                        });
                      }
                    },
                    preload: isPrimaryPreloading,
                  ),
                ),
                viewModel.isLoggedOut
                    ? Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TransparentButton(
                                fontSize: 14,
                                label: I18n.of(context).restore_backup,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Recovery');
                                }),
                            Text(
                              I18n.of(context).or,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            TransparentButton(
                                fontSize: 14,
                                label: I18n.of(context).create__wallet,
                                onPressed: () {
                                  viewModel.createLocalAccount(() {
                                    setState(() {
                                      isTransparentPreloading = false;
                                    });
                                    Navigator.pushNamed(context, '/Signup');
                                  });
                                  setState(() {
                                    isTransparentPreloading = true;
                                  });
                                },
                                preload: isTransparentPreloading)
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TransparentButton(
                            fontSize: 16,
                            label: I18n.of(context).restore_from_backup,
                            onPressed: () {
                              Navigator.pushNamed(context, '/Recovery');
                            }),
                      )
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/transparent_button.dart';
import 'package:redux/redux.dart';

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
        converter: (Store<AppState> store) {
          return SplashViewModel.fromStore(store);
        },
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
                        viewModel.isLoggedOut ? "Login" : "Create a new wallet",
                    onPressed: () {
                      if (viewModel.isLoggedOut) {
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
                                label: "Restore backup",
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Recovery');
                                }),
                            Text(
                              'or',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            TransparentButton(
                                fontSize: 14,
                                label: "Create wallet",
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
                            label: "Restore from backup",
                            onPressed: () {
                              Navigator.pushNamed(context, '/Recovery');
                            }),
                      )

                // Padding(
                //     padding: EdgeInsets.only(top: 20),
                //     child: TransparentButton(
                //         fontSize: 16,
                //         label: viewModel.isLoggedOut
                //             ? "Create a new wallet"
                //             : "Restore from backup",
                //         onPressed: () {
                //           if (viewModel.isLoggedOut) {
                //             viewModel.createLocalAccount(() {
                //               setState(() {
                //                 isTransparentPreloading = false;
                //               });
                //               Navigator.pushNamed(context, '/Signup');
                //             });
                //             setState(() {
                //               isTransparentPreloading = true;
                //             });
                //           } else {
                //             Navigator.pushNamed(context, '/Recovery');
                //           }
                //         },
                //         preload: isTransparentPreloading)),
                // viewModel.isLoggedOut
                //     ? Padding(
                //         padding: EdgeInsets.only(top: 20),
                //         child: TransparentButton(
                //             label: "Restore from backup",
                //             onPressed: () {
                //               Navigator.pushNamed(context, '/Recovery');
                //             }))
                //     : SizedBox.shrink()
              ],
            ),
          );
        });
  }
}

class SplashViewModel {
  final String privateKey;
  final String jwtToken;
  final bool isLoggedOut;
  final Function(String) initWeb3;
  final Function(VoidCallback successCallback) createLocalAccount;

  SplashViewModel(
      {this.privateKey,
      this.jwtToken,
      this.isLoggedOut,
      this.initWeb3,
      this.createLocalAccount});

  static SplashViewModel fromStore(Store<AppState> store) {
    return SplashViewModel(
        privateKey: store.state.userState.privateKey,
        jwtToken: store.state.userState.jwtToken,
        isLoggedOut: store.state.userState.isLoggedOut,
        initWeb3: (privateKey) {
          store.dispatch(initWeb3Call(privateKey));
        },
        createLocalAccount: (VoidCallback successCallback) {
          store.dispatch(createLocalAccountCall(successCallback));
        }
        // accountAddress: store.state.userState.accountAddress,
        // loginRequestSuccess: store.state.userState.loginRequestSuccess,
        // loginVerifySuccess: store.state.userState.loginVerifySuccess,
        // signUp: (countryCode, phoneNumber, successCallback, failCallback) {
        //   store.dispatch(loginRequestCall(countryCode, phoneNumber, successCallback, failCallback));
        // },
        // verify: (countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback) {
        //   store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress, successCallback, failCallback));
        // }
        );
  }

  bool operator ==(other) {
    if (other is SplashViewModel) {
      if (privateKey == other.privateKey &&
          jwtToken == other.jwtToken &&
          isLoggedOut == other.isLoggedOut) return true;
    }
    return false;
  }
}

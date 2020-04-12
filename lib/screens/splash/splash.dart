import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wiki_bank/models/app_state.dart';
import 'package:wiki_bank/models/views/splash.dart';
import 'package:wiki_bank/redux/actions/cash_wallet_actions.dart';
import 'package:wiki_bank/redux/actions/user_actions.dart';
import 'package:wiki_bank/screens/routes.gr.dart';
import 'package:wiki_bank/screens/splash/create_wallet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  onInit(store) {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
      store.dispatch(getWalletAddressessCall());
      store.dispatch(identifyCall());
      Router.navigator.pushNamedAndRemoveUntil(
          Router.cashHomeScreen, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer();
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        onInit: onInit,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return Scaffold(
              drawer: drawer,
              body: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/wikibank_logo.png',
                    width: 350,
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Caja de Ahorros Digitales',
                            style: TextStyle(
                                fontFamily: 'Eras',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 18),
                          ),
                          Text(
                            '\nde Triana',
                            style: TextStyle(
                                fontFamily: 'Eras',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/1.jpg',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset('assets/images/2.png',
                              width: 100, height: 100),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/3.jpg',
                              width: 100, height: 100),
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset('assets/images/4.jpg',
                              width: 100, height: 100),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CreateWallet()
                ],
              )));
        });
  }
}

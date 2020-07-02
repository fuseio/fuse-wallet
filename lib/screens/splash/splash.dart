import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/views/splash.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/redux/actions/user_actions.dart';
import 'package:peepl/screens/routes.gr.dart';
import 'package:peepl/widgets/on_boarding_pages.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  onInit(Store<AppState> store) {
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
          List pages = getPages(context);
          return Scaffold(
              drawer: drawer,
              body: Container(
                  child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 20,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: new Stack(
                            children: <Widget>[
                              new PageView.builder(
                                physics: new AlwaysScrollableScrollPhysics(),
                                itemCount: pages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return pages[index % pages.length];
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              )));
        });
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/views/splash.dart';
import 'package:supervecina/screens/splash/create_wallet.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/splash-screen');
    return StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return WillPopScope(
              onWillPop: () async {
                ExtendedNavigator.root.pop<bool>(false);
                return false;
              },
              child: Scaffold(
                  body: Container(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Image.asset(
                      'assets/images/wikibank_logo.png',
                      width: 350,
                      // height: 300,
                    ),
                  ),
                  Flexible(
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
                            '\nde Sevilla',
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
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/2.png',
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 100),
                      ],
                    ),
                  ),
                  Flexible(flex: 2, child: CreateWallet()),
                ],
              ))));
        });
  }
}

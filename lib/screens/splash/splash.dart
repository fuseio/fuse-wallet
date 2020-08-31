import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/views/splash.dart';
import 'package:esol/screens/splash/create_wallet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final List pages = [CreateWallet()];
    return StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          return WillPopScope(
              onWillPop: () {
                return Future(() => false);
              },
              child: Scaffold(
                  body: Container(
                      child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 20,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              PageView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
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
              ))));
        });
  }
}

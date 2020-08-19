import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fc_knudde/models/app_state.dart';
import 'package:fc_knudde/models/views/splash.dart';
import 'package:fc_knudde/screens/splash/create_wallet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          List pages = [CreateWallet()];
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

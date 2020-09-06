import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/views/splash.dart';
import 'package:esol/screens/splash/create_wallet.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          return WillPopScope(
              onWillPop: () {
                return Future(() => false);
              },
              child: Scaffold(
                  body: Stack(
                children: [
                  SvgPicture.asset('assets/images/splash_cloud.svg',
                      fit: BoxFit.cover),
                  Container(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Expanded(
                              child: CreateWallet(),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ))
                ],
              )));
        });
  }
}

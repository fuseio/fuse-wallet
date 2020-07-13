import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/views/splash.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/widgets/on_boarding_pages.dart';
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
      Router.navigator.pushNamedAndRemoveUntil(
          Router.cashHomeScreen, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer();
    return StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        onInit: onInit,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          List<Widget> pages = getPages();
          return new WillPopScope(
              onWillPop: () {
                return Future(() => false);
              },
              child: Scaffold(
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
                                    physics:
                                        new AlwaysScrollableScrollPhysics(),
                                    itemCount: pages.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
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

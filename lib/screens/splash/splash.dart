import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/models/views/splash.dart';
import 'package:roost/widgets/on_boarding_pages.dart';
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return SplashViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          var drawer = Drawer();
          List pages = getPages(context);
          return Scaffold(
              drawer: drawer,
              body: new StoreBuilder(onInitialBuild: (store) {
                if (viewModel.privateKey != '' &&
                    viewModel.jwtToken != '' &&
                    !viewModel.isLoggedOut) {
                  viewModel.initWeb3(viewModel.privateKey);
                  if (Navigator.canPop(context)) {
                    Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                  } else {
                    Navigator.pushReplacementNamed(context, '/Cash');
                  }
                }
              }, builder: (BuildContext context, Store<AppState> store) {
                return Container(
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
                ));
              }));
        });
  }
}

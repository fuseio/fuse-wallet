import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/splash.dart';
import 'package:fusecash/screens/splash/slide_animation_controller.dart';
import 'package:fusecash/widgets/on_boarding_pages.dart';
import 'package:redux/redux.dart';
import 'dots_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  static const _kDuration = const Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  bool isOpen = false;
  HouseController _slideController;
  ValueNotifier<double> notifier;
  int _previousPage;

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;

    _slideController.rooms = _pageController.page;
  }

  @override
  void initState() {
    _slideController = HouseController(demoUpdated: _update);

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    notifier = ValueNotifier<double>(0);

    _previousPage = _pageController.initialPage;

    super.initState();
  }

  _update() => setState(() {});

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                              flex: 10,
                              fit: FlexFit.tight,
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: FlareActor(
                                    "assets/images/animation.flr",
                                    alignment: Alignment.bottomCenter,
                                    fit: BoxFit.contain,
                                    controller: _slideController,
                                  ))),
                          Expanded(
                            flex: 3,
                            child: Container(
                                constraints: BoxConstraints.expand(),
                                child: new PageView.builder(
                                  physics: new AlwaysScrollableScrollPhysics(),
                                  controller: _pageController,
                                  itemCount: 4,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return getPages(context)[index % 4];
                                  },
                                )),
                          ),
                          Flexible(
                            flex: 2,
                            child: new Container(
                              child: new Center(
                                child: new DotsIndicator(
                                  controller: _pageController,
                                  itemCount: 4,
                                  onPageSelected: (int page) {
                                    gotoPage(page);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
              }));
        });
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/splash.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/screens/splash/slide_animation_controller.dart';
import 'package:fusecash/widgets/on_boarding_pages.dart';
import 'dots_indicator.dart';
import 'package:redux/redux.dart';

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
    super.initState();
    _slideController = HouseController(demoUpdated: _update);

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    notifier = ValueNotifier<double>(0);

    _previousPage = _pageController.initialPage;
  }

  _update() => setState(() {});

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
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
          return new WillPopScope(
              onWillPop: () {
                return new Future(() => false);
              },
              child: Scaffold(
                  drawer: drawer,
                  body: Container(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 20,
                          child: Container(
                            child: new Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 100, left: 20, right: 20),
                                  child: FlareActor(
                                    "assets/images/animation.flr",
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    controller: _slideController,
                                  ),
                                ),
                                new PageView.builder(
                                  physics: new AlwaysScrollableScrollPhysics(),
                                  controller: _pageController,
                                  itemCount: pages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          pages[index % 4],
                                ),
                                new Positioned(
                                  bottom: 15.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: new Container(
                                    padding: const EdgeInsets.all(20.0),
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
                          )),
                    ],
                  ))));
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/views/splash.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:paywise/redux/actions/user_actions.dart';
import 'package:paywise/screens/routes.gr.dart';
import 'package:paywise/widgets/on_boarding_pages.dart';
import 'dots_indicator.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = new PageController();
  static const _kDuration = const Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  bool isOpen = false;
  PageController _slideController;
  ValueNotifier<double> notifier;
  int _previousPage;
  final _controller = new PageController();

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;

    _slideController.animateToPage(_pageController.page.toInt(),
        duration: null, curve: null);
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    notifier = ValueNotifier<double>(0);

    _previousPage = _pageController.initialPage;
    super.initState();
  }

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
                                controller: _controller,
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
                                      controller: _controller,
                                      itemCount: pages.length,
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
                    )),
                  ),
                ],
              )));
        });
  }
}

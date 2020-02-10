// import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/views/splash.dart';
import 'package:paywise/screens/splash/create_wallet.dart';
import 'package:paywise/screens/splash/dots_indicator.dart';
import 'package:paywise/widgets/on_boarding_pages.dart';
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

  var _pages = <Widget>[
    Image.asset('assets/images/phone.png', width: 160),
    Image.asset('assets/images/send.png', width: 160),
    Image.asset('assets/images/world.png', width: 160),
    CreateWallet()
  ];

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
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Expanded(
                            child: new Stack(
                              children: <Widget>[
                                new PageView.builder(
                                  physics: new AlwaysScrollableScrollPhysics(),
                                  controller: _controller,
                                  itemCount: _pages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return getPages(context)[index % _pages.length];
                                  },
                                ),
                                new Positioned(
                                  bottom: 15.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: new Container(
                                    //color: Colors.grey[800].withOpacity(0.5),
                                    padding: const EdgeInsets.all(20.0),
                                    child: new Center(
                                      child: new DotsIndicator(
                                        controller: _controller,
                                        itemCount: _pages.length,
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
                      )
                          // new Stack(
                          //   children: <Widget>[
                          //     Padding(
                          //       padding: EdgeInsets.only(bottom: 100),
                          //       child: new PageView.builder(
                          //         physics: new AlwaysScrollableScrollPhysics(),
                          //         controller: PageController(initialPage: 0),
                          //         itemCount: _pages.length,
                          //         itemBuilder:
                          //             (BuildContext context, int index) {
                          //           return _pages[index % _pages.length];
                          //         },
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.only(bottom: 100),
                          //       child: new PageView.builder(
                          //         physics: new AlwaysScrollableScrollPhysics(),
                          //         controller: _pageController,
                          //         itemCount: 4,
                          //         itemBuilder:
                          //             (BuildContext context, int index) {
                          //           return getPages(context)[index % 4];
                          //         },
                          //       ),
                          //     ),
                          //     new Positioned(
                          //       bottom: 30.0,
                          //       left: 0.0,
                          //       right: 0.0,
                          //       child: new Center(
                          //           child: new DotsIndicator(
                          //             controller: _pageController,
                          //             itemCount: 4,
                          //             onPageSelected: (int page) {
                          //               gotoPage(page);
                          //             },
                          //           ),
                          //         ),
                          //     ),
                          // new Positioned(
                          //   bottom: 15.0,
                          //   left: 0.0,
                          //   right: 0.0,
                          //   child: new Container(
                          //     padding: const EdgeInsets.all(20.0),
                          //     child: new Center(
                          //       child: new DotsIndicator(
                          //         controller: _controller,
                          //         itemCount: _pages.length,
                          //         onPageSelected: (int page) {
                          //           gotoPage(page);
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // ],
                          // ),
                          // )),
                          // Expanded(
                          //   flex: 20,
                          //   child: Container(
                          //     decoration: BoxDecoration(),
                          //     child: Column(
                          //       children: <Widget>[
                          //         Expanded(
                          //           child: new Stack(
                          //             children: <Widget>[
                          //               Padding(
                          //                 padding: const EdgeInsets.only(top: 100),
                          //                 child: Image.asset(
                          //                   'assets/images/paywise.png',
                          //                   fit: BoxFit.fill,
                          //                 ),
                          //               ),
                          //               Container(
                          //                 color: Colors.transparent,
                          //                 child: Padding(
                          //                     padding: EdgeInsets.only(bottom: 20),
                          //                     child: Align(
                          //                         alignment: Alignment.bottomCenter,
                          //                         child: CreateWallet())),
                          //               )
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          ),
                    ),
                  ],
                ));
              }));
        });
  }
}

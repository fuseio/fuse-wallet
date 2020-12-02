import 'package:auto_route/auto_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:gooddollar/models/app_state.dart';
import 'package:gooddollar/models/views/splash.dart';
import 'package:gooddollar/screens/splash/slide_animation_controller.dart';
import 'package:gooddollar/widgets/on_boarding_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/splash-screen');
        },
        distinct: true,
        converter: SplashViewModel.fromStore,
        builder: (_, viewModel) {
          List pages = getPages(context);
          return WillPopScope(
              onWillPop: () async {
                ExtendedNavigator.root.pop<bool>(false);
                return false;
              },
              child: Scaffold(
                  body: Container(
                      child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 20,
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 100, left: 20, right: 20),
                              child: FlareActor(
                                "assets/images/",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                controller: _slideController,
                              ),
                            ),
                            PageView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: _pageController,
                              itemCount: pages.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  pages[index % 4],
                            ),
                            Positioned(
                              bottom: 15.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  // child: SmoothPageIndicator(
                                  //   controller: _pageController,
                                  //   count: 4,
                                  //   effect: JumpingDotEffect(
                                  //       dotWidth: 9.0,
                                  //       dotHeight: 9.0,
                                  //       activeDotColor: Color(0xFF696B6D)),
                                  //   onDotClicked: gotoPage,
                                  // ),
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

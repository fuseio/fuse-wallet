import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/views/splash.dart';
import 'package:peepl/screens/splash/on_boarding_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  int _previousPage;
  ValueNotifier<double> notifier;

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);
  }

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    List pages = getPages(context);
    return StoreConnector<AppState, SplashViewModel>(
      onInitialBuild: (viewModel) {
        Segment.screen(screenName: '/splash-screen');
      },
      distinct: true,
      converter: SplashViewModel.fromStore,
      builder: (_, viewModel) {
        return Scaffold(
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
                                controller: _pageController,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        pages[index % pages.length],
                              ),
                              Positioned(
                                bottom: 15.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: pages.length,
                                      effect: JumpingDotEffect(
                                        dotWidth: 9.0,
                                        dotHeight: 9.0,
                                        activeDotColor: Color(0xFF696B6D),
                                      ),
                                      onDotClicked: gotoPage,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

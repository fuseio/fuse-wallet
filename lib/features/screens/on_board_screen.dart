import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/features/onboard/widegts/flare_controller.dart';
import 'package:fusecash/features/onboard/widegts/on_boarding_pages.dart';
import 'package:fusecash/features/onboard/widegts/sign_up_buttons.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  late HouseController _slideController;
  late ValueNotifier<double> notifier;
  double page = 0;
  int cont = 0;
  bool animate = false;

  void _onScroll() {
    _slideController.rooms = _pageController.page!;
  }

  @override
  void initState() {
    super.initState();
    _slideController = HouseController(onUpdated: _update);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);
  }

  _update() => setState(() {});

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
    final List<Widget> welcomeScreens = [
      WelcomeFrame(
        title: I10n.of(context).simple,
        subTitle: I10n.of(context).intro_text_one,
      ),
      WelcomeFrame(
        title: I10n.of(context).useful,
        subTitle: I10n.of(context).intro_text_two,
      ),
      WelcomeFrame(
        title: I10n.of(context).smart,
        subTitle: I10n.of(context).intro_text_three,
      ),
      SignUpButtons()
    ];
    return Scaffold(
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
                        bottom: 100,
                        left: 20,
                        right: 20,
                      ),
                      child: FlareActor(
                        "assets/images/animation.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        controller: _slideController,
                      ),
                    ),
                    PageView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: welcomeScreens.length,
                      itemBuilder: (_, index) => welcomeScreens[index % 4],
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
                            count: 4,
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
            ),
          ],
        ),
      ),
    );
  }
}

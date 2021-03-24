import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/welcome_frame.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  double page = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    _pageController.addListener(() {
      setState(() {
        page = _pageController.page;
      });
    });
    super.initState();
  }

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
    List<Widget> welcomeScreens = [
      WelcomeFrame(
        title: I18n.of(context).simple,
        subTitle: I18n.of(context).intro_text_one,
        lottieImagePath: 'assets/lottie/1.json',
      ),
      WelcomeFrame(
        title: I18n.of(context).useful,
        subTitle: I18n.of(context).intro_text_two,
        lottieImagePath: 'assets/lottie/2.json',
      ),
      WelcomeFrame(
        title: I18n.of(context).smart,
        subTitle: I18n.of(context).intro_text_three,
        lottieImagePath: 'assets/lottie/3.json',
      ),
      WelcomeFrame(
        showButtons: true,
        lottieImagePath: 'assets/lottie/4.json',
      ),
      // CreateWallet()
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lottie.asset(
            //   'assets/lottie/title.json',
            //   frameRate: FrameRate.max,
            //   repeat: true,
            // ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: welcomeScreens.length,
                itemBuilder: (_, index) => welcomeScreens[index],
              ),
            ),
            TweenAnimationBuilder(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  onDotClicked: gotoPage,
                  count: welcomeScreens.length,
                  effect: JumpingDotEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    dotColor: Theme.of(context).colorScheme.onSurface,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 2000),
              builder: (BuildContext context, double _val, Widget child) =>
                  Opacity(
                opacity: _val,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

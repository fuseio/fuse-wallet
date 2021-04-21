import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/features/onboard/widegts/sign_up_buttons.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/welcome_text.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _lottieController;
  AnimationController _titleController;
  Animation<Offset> _offset;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  double page = 0;
  int cont = 0;
  bool animate = false;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    _titleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _lottieController = AnimationController(vsync: this);

    _offset =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 12.0)).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: Curves.ease,
      ),
    );

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        cont++;
        final int currentPage = ((page.toInt() + 1) ?? 1);
        if (cont < double.infinity) {
          if (currentPage == 1) {
            _lottieController.reset();
            _lottieController.forward(from: .5);
          } else if (currentPage == 3) {
            _lottieController.reset();
            _lottieController.forward(from: .5);
          } else {
            _lottieController.reset();
            _lottieController.forward();
          }
        }
      }
    });

    _pageController.addListener(() {
      final int currentPage = ((_pageController.page.toInt() + 1) ?? 1);
      if (currentPage == 1) {
        _lottieController.forward(from: 0.25);
      } else {
        _lottieController.reset();
        _lottieController.forward();
      }

      if (_pageController.page > 2.9) {
        _titleController.forward();
        setState(() {
          animate = true;
        });
      } else {
        setState(() {
          animate = false;
        });
        _titleController.reverse();
      }
      setState(() {
        cont = 0;
        page = _pageController.page;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _lottieController.dispose();
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
      WelcomeTitle(
        title: I18n.of(context).simple,
        subTitle: I18n.of(context).intro_text_one,
        delay: 1000,
      ),
      WelcomeTitle(
        title: I18n.of(context).useful,
        subTitle: I18n.of(context).intro_text_two,
      ),
      WelcomeTitle(
        title: I18n.of(context).smart,
        subTitle: I18n.of(context).intro_text_three,
      ),
      SignUpButtons()
    ];
    final String currentPage = ((page.toInt() + 1) ?? 1).toString();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              top: animate ? 120 : 10,
              width: MediaQuery.of(context).size.width,
              duration: Duration(milliseconds: 1000),
              curve: Curves.ease,
              child: SlideTransition(
                position: _offset,
                child: SvgPicture.asset(
                  'assets/images/fuse-logo-title.svg',
                  width: 130,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Transform.scale(
                scale: 1.45,
                child: Lottie.asset(
                  'assets/lottie/$currentPage.json',
                  controller: _lottieController,
                  frameRate: FrameRate.max,
                  onLoaded: (LottieComposition composition) {
                    _lottieController
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: welcomeScreens.length,
              itemBuilder: (_, index) => welcomeScreens[index],
            ),
            Positioned(
              bottom: 5.0,
              left: 0.0,
              right: 0.0,
              child: TweenAnimationBuilder(
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
            ),
          ],
        ),
      ),
    );
  }
}

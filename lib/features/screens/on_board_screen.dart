import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:fusecash/features/onboard/widgets/sign_up_buttons.dart';
import 'package:fusecash/features/shared/widgets/flare_controller.dart';
import 'package:fusecash/features/shared/widgets/on_boarding_pages.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  late HouseController _slideController;
  late ValueNotifier<double> notifier;
  late ValueNotifier<double> _currentPage;
  double page = 0;
  int cont = 0;
  bool animate = false;

  void _onScroll() {
    _slideController.rooms = _pageController.page!;
  }

  @override
  void initState() {
    super.initState();
    _currentPage = ValueNotifier<double>(0);
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
    _currentPage.value = page.toDouble();
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
        delay: 1000,
      ),
      WelcomeFrame(
        title: I10n.of(context).useful,
        subTitle: I10n.of(context).intro_text_two,
      ),
      WelcomeFrame(
        title: I10n.of(context).smart,
        subTitle: I10n.of(context).intro_text_three,
      ),
      const SignUpButtons()
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.79,
              child: FlareActor(
                "assets/images/animation.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                controller: _slideController,
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: welcomeScreens.length,
              itemBuilder: (_, index) => welcomeScreens[index],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 2000),
                      builder:
                          (BuildContext context, double val, Widget? child) =>
                              Opacity(
                        opacity: val,
                        child: child,
                      ),
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
                    ValueListenableBuilder<double>(
                      valueListenable: _currentPage,
                      builder: (context, value, child) {
                        if (value < welcomeScreens.length - 1) {
                          return AnimatedOpacity(
                            opacity: value < welcomeScreens.length - 1 ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: child,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      child: IconButton(
                        onPressed: () {
                          final int nextPage = (_currentPage.value.toInt() + 1);
                          gotoPage(nextPage);
                        },
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          size: 25,
                          color: Theme.of(context).colorScheme.primary,
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

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
// import 'package:fusecash/features/onboard/widegts/create_or_restore.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/onboard/widegts/flare_controller.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:fusecash/widgets/welcome_frame.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  HouseController _slideController;
  ValueNotifier<double> notifier;

  void _onScroll() {
    _slideController.rooms = _pageController.page;
  }

  @override
  void initState() {
    super.initState();
    _slideController = HouseController(onUpdated: _update);

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);
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
        title: '',
        subTitle: '',
        lottieImagePath: 'assets/lottie/4.json',
      ),
      // CreateWallet()
    ];
    return StoreConnector<AppState, SplashViewModel>(
      onInitialBuild: (viewModel) {
        Segment.screen(screenName: '/splash-screen');
      },
      distinct: true,
      converter: SplashViewModel.fromStore,
      builder: (_, viewModel) {
        return PageView(
          // physics: AlwaysScrollableScrollPhysics(),
          controller: _pageController,
          children: welcomeScreens,
          // itemCount: welcomeScreens.length,
          // itemBuilder: (_, index) => welcomeScreens[index],
        );
      },
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key}) : super(key: key);
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  bool isContactSynced = false;
  late ConfettiController _controllerBottomCenter;

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void initState() async {
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    Contacts.checkPermissions().then((value) {
      setState(() {
        isContactSynced = value;
      });
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage?.data['isTopUp'] == 'true') {
      context.router.popUntilRoot();
      Segment.track(eventName: 'fUSD Purchase Success');
      _controllerBottomCenter.play();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, HomeScreenViewModel>(
      distinct: true,
      converter: HomeScreenViewModel.fromStore,
      onInit: (store) {
        store.dispatch(fetchSwapList());
        store.dispatch(startFetchingCall());
        store.dispatch(startFetchTokensBalances());
        store.dispatch(updateTokensPrices());
      },
      builder: (_, vm) {
        return AutoTabsScaffold(
          // appBarBuilder: (_, tabsRouter) => AppBar(
          //   title: Text(context.topRoute.name),
          //   leading: AutoBackButton(),
          // ),
          routes: [
            HomeTab(),
            ContactsTab(),
            SwapTab(),
            EarnTab(),
            AccountTab(),
          ],
          bottomNavigationBuilder: (_, TabsRouter tabs) => BottomBar(tabs),
        );
        // return Scaffold(
        //   body: IndexedStack(
        //     index: currentIndex,
        //     children: <Widget>[
        //       ExtendedNavigator(
        //         router: HomeRouter(),
        //         name: 'homeRouter',
        //         observers: [
        //           FirebaseAnalyticsObserver(
        //               analytics: getIt<FirebaseAnalytics>()),
        //           SegmentObserver(),
        //           SentryNavigatorObserver(),
        //         ],
        //       ),
        //       ExtendedNavigator(
        //         router: ContactsRouter(),
        //         name: 'contactsRouter',
        //         observers: [
        //           FirebaseAnalyticsObserver(
        //               analytics: getIt<FirebaseAnalytics>()),
        //           SegmentObserver(),
        //           SentryNavigatorObserver(),
        //         ],
        //       ),
        //       ExtendedNavigator(
        //         router: SwapRouter(),
        //         name: 'swapRouter',
        //         observers: [
        //           FirebaseAnalyticsObserver(
        //               analytics: getIt<FirebaseAnalytics>()),
        //           SegmentObserver(),
        //           SentryNavigatorObserver(),
        //         ],
        //       ),
        //       ExtendedNavigator(
        //         router: AccountRouter(),
        //         name: 'accountRouter',
        //         observers: [
        //           FirebaseAnalyticsObserver(
        //               analytics: getIt<FirebaseAnalytics>()),
        //           SegmentObserver(),
        //           SentryNavigatorObserver(),
        //         ],
        //       ),
        //     ],
        //   ),
        //   bottomNavigationBar: BottomBar(
        //     tabIndex: currentIndex,
        //     onTap: (index) {
        //       _onTap(index);
        //       if (vm.isContactsSynced == null &&
        //           index == 1 &&
        //           !isContactSynced) {
        //         Future.delayed(
        //           Duration.zero,
        //           () => showDialog(
        //             context: context,
        //             builder: (_) => ContactsConfirmationScreen(),
        //           ),
        //         );
        //       }
        //       if (index == 2) {
        //         vm.getSwapList();
        //       }
        //       if (!vm.backup && !vm.isBackupDialogShowed && index == 3) {
        //         Future.delayed(Duration.zero, () {
        //           vm.setShowDialog();
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return BackUpDialog();
        //             },
        //           );
        //         });
        //       }
        //     },
        //   ),
        // );
      },
    );
  }
}

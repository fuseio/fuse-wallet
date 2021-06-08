import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/features/account/router/router.gr.dart';
import 'package:fusecash/features/contacts/dialogs/enable_contacts.dart';
import 'package:fusecash/features/earn/router/router.gr.dart';
import 'package:fusecash/features/home/router/router.gr.dart';
import 'package:fusecash/features/contacts/router/router.gr.dart';
import 'package:fusecash/features/swap/router/swap_router.gr.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:confetti/confetti.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key key}) : super(key: key);
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();

  static _MainHomeScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<_MainHomeScreenState>();
  }
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int currentIndex = 0;
  bool isContactSynced = false;
  ConfettiController _controllerBottomCenter;

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
  void initState() {
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    Contacts.checkPermissions().then((value) {
      setState(() {
        isContactSynced = value;
      });
    });

    void startBonusAnimation(message) {
      final dynamic data = message['data'] ?? message;
      final bool isTopUp =
          data['isTopUp'] != null && data['isTopUp'] == 'true' ? true : false;

      if (isTopUp) {
        Segment.track(eventName: 'fUSD Purchase Success');
        _controllerBottomCenter.play();
      }
    }

    getIt<FirebaseMessaging>().configure(
      onMessage: (Map<String, dynamic> message) async {
        startBonusAnimation(message);
      },
      onResume: (Map<String, dynamic> message) async {
        startBonusAnimation(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        startBonusAnimation(message);
      },
    );
    super.initState();
  }

  void _onTap(int itemIndex) {
    if (!mounted) return;
    setState(() {
      currentIndex = itemIndex;
    });
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
        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.center,
            overflow: Overflow.visible,
            children: [
              IndexedStack(
                index: currentIndex,
                children: <Widget>[
                  ExtendedNavigator(
                    router: HomeRouter(),
                    name: 'homeRouter',
                    observers: [
                      SentryNavigatorObserver(),
                    ],
                  ),
                  ExtendedNavigator(
                    router: ContactsRouter(),
                    name: 'contactsRouter',
                    observers: [
                      SentryNavigatorObserver(),
                    ],
                  ),
                  ExtendedNavigator(
                    router: SwapRouter(),
                    name: 'swapRouter',
                    observers: [
                      SentryNavigatorObserver(),
                    ],
                  ),
                  ExtendedNavigator(
                    router: EarnRouter(),
                    name: 'earnRouter',
                    observers: [
                      SentryNavigatorObserver(),
                    ],
                  ),
                  ExtendedNavigator(
                    router: AccountRouter(),
                    name: 'accountRouter',
                    observers: [
                      SentryNavigatorObserver(),
                    ],
                  ),
                ],
              ),
              Positioned(
                child: ConfettiWidget(
                  confettiController: _controllerBottomCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomBar(
            tabIndex: currentIndex,
            onTap: (index) {
              _onTap(index);
              if (vm.isContactsSynced == null &&
                  index == 1 &&
                  !isContactSynced) {
                Future.delayed(
                  Duration.zero,
                  () => showDialog(
                    context: context,
                    builder: (_) => ContactsConfirmationScreen(),
                  ),
                );
              }
              if (index == 2) {
                vm.getSwapListBalances();
              }
              // if (!vm.backup && !vm.isBackupDialogShowed && index == 3) {
              //   Future.delayed(Duration.zero, () {
              //     vm.setShowDialog();
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return BackUpDialog();
              //       },
              //     );
              //   });
              // }
            },
          ),
        );
      },
    );
  }
}

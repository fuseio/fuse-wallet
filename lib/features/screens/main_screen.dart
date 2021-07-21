import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fusecash/features/shared/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/main_screen.dart';
import 'package:upgrader/upgrader.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TabsRouter _tabsRouter;
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
  void initState() {
    Function handleFCM = (RemoteMessage? remoteMessage) {
      if (remoteMessage?.data['isTopUp'] == 'true') {
        context.router.popTop();
        Segment.track(eventName: 'fUSD Purchase Success');
        _controllerBottomCenter.play();
      }
    };

    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      handleFCM(remoteMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      handleFCM(remoteMessage);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      handleFCM(remoteMessage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    final AppcastConfiguration cfg = AppcastConfiguration(
      url:
          'https://raw.githubusercontent.com/fuseio/fuse-wallet/fusecash/appcast-fusecash.xml',
      supportedOS: ['android'],
    );
    return WillPopScope(
      onWillPop: () {
        if (_tabsRouter.canPopSelfOrChildren) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          StoreConnector<AppState, MainScreenViewModel>(
            distinct: true,
            converter: MainScreenViewModel.fromStore,
            onWillChange: (previousViewModel, newViewModel) {
              if (previousViewModel?.justClaimed != newViewModel.justClaimed &&
                  newViewModel.justClaimed) {
                Future.delayed(Duration(milliseconds: 2500), () {
                  _controllerBottomCenter.play();
                  newViewModel.resetJustClaim(false);
                });
              }
            },
            builder: (_, viewModel) => UpgradeAlert(
              appcastConfig: cfg,
              showIgnore: false,
              showReleaseNotes: false,
              durationToAlertAgain: Duration(hours: 5),
              countryCode: viewModel.countryCode,
              child: AutoTabsScaffold(
                animationDuration: Duration(milliseconds: 0),
                routes: [
                  HomeTab(),
                  ContactsTab(),
                  SwapTab(),
                  EarnTab(),
                  AccountTab(),
                ],
                bottomNavigationBuilder: (_, TabsRouter tabs) {
                  _tabsRouter = tabs;
                  return BottomBar(tabs);
                },
              ),
            ),
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
              createParticlePath: drawStar,
            ),
          ),
        ],
      ),
    );
  }
}

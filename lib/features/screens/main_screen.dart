import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:upgrader/upgrader.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/dialogs/wallet_upgrade.dart';
import 'package:fusecash/features/shared/widgets/background_duration_detector.dart';
import 'package:fusecash/features/shared/widgets/bottom_bar.dart';
import 'package:fusecash/features/shared/widgets/wallet_connect_listener.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/crashlytics.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends SfWidget<MainPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      checkForUpdate();
    }
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log.info('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) async {
      if (UpdateAvailability.updateAvailable == info.updateAvailability) {
        try {
          await InAppUpdate.performImmediateUpdate();
        } catch (e, s) {
          Crashlytics.recordError(
            Exception(
                'Error while perform immediate update on android: ${e.toString()}'),
            s,
          );
        }
      }
    }).catchError((e, s) {
      Crashlytics.recordError(
        Exception('Error while check for update on android: ${e?.toString()}'),
        s,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final connected = _connectionStatus != ConnectivityResult.none;
    final Widget body = StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.userState.hasUpgrade,
      onWillChange: (previousViewModel, newViewModel) {
        if ((previousViewModel != newViewModel) && newViewModel) {
          const WalletUpgradeDialog().showSheet(context);
        }
      },
      builder: (_, viewModel) => AutoTabsScaffold(
        appBarBuilder: !connected
            ? (context, tabsRouter) => AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  title: AutoSizeText(
                    I10n.of(context).not_connected,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).canvasColor,
                        ),
                  ),
                )
            : null,
        animationCurve: Curves.fastOutSlowIn,
        routes: const [
          HomeTab(),
          WalletTab(),
          SwapTab(),
          AccountTab(),
        ],
        bottomNavigationBuilder: (_, TabsRouter tabs) => BottomBar(tabs),
      ),
    );

    return BackgroundDetector(
      allowedDurationOnBackground: const Duration(milliseconds: 60000),
      onAllowedDurationExpired: () {
        context.router.replace(SplashRoute());
      },
      child: WCListener(
        child: Platform.isIOS
            ? UpgradeAlert(
                upgrader: Upgrader(
                  showIgnore: false,
                  showReleaseNotes: false,
                  durationUntilAlertAgain: const Duration(hours: 5),
                  countryCode: StoreProvider.of<AppState>(context)
                      .state
                      .userState
                      .countryCode,
                ),
                child: body,
              )
            : body,
      ),
    );
  }
}

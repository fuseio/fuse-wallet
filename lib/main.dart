import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localdolarmx/main_wrapper.dart';
import 'package:localdolarmx/models/app_state.dart';
import 'package:localdolarmx/models/views/splash.dart';
import 'package:localdolarmx/redux/actions/cash_wallet_actions.dart';
import 'package:localdolarmx/redux/actions/user_actions.dart';
import 'package:localdolarmx/redux/state/store.dart';
import 'package:localdolarmx/themes/app_theme.dart';
import 'package:localdolarmx/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:localdolarmx/generated/i18n.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String configFile = String.fromEnvironment('CONFIG_FILE', defaultValue: '.env_localdolarmx');
  await DotEnv().load(configFile);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runZoned<Future<void>>(() async => runApp(await customThemeApp()),
      onError: (Object error, StackTrace stackTrace) async {
    try {
      await AppFactory().reportError(error, stackTrace);
    } catch (e) {
      print('Sending report to sentry.io failed: $e');
      print('Original error: $error');
    }
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    if (AppFactory().isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

Future<CustomTheme> customThemeApp() async {
  return CustomTheme(
    initialThemeKey: MyThemeKeys.DEFAULT,
    child: new MyApp(
      store: await AppFactory().getStore(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState(store);
}

class _MyAppState extends State<MyApp> {
  Store<AppState> store;
  _MyAppState(this.store);
  final i18n = I18n.delegate;
  bool isProMode = false;
  bool isNavigated = false;
  bool isLoggedIn = false;

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    I18n.onLocaleChanged = onLocaleChange;
  }

  onInitialBuild(vm) {
    if (vm.privateKey.isNotEmpty && vm.jwtToken.isNotEmpty && !vm.isLoggedOut) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  onWillChange(prevVM, nextVM) {
    if (prevVM.isProMode != nextVM.isProMode) {
      setState(() {
        isProMode = nextVM.isProMode;
        isNavigated = false;
      });
    }
  }

  onInit(store) {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    String communityManager = store.state.cashWalletState.communityManagerAddress;
    String transferManager = store.state.cashWalletState.transferManagerAddress;
    if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
      store.dispatch(getWalletAddressessCall(
          communityManager: communityManager,
          transferManager: transferManager));
      store.dispatch(identifyCall());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));
    return new StoreProvider<AppState>(
      store: store,
      child: new StoreConnector<AppState, SplashViewModel>(
          converter: SplashViewModel.fromStore,
          onInitialBuild: onInitialBuild,
          onWillChange: onWillChange,
          onInit: onInit,
          builder: (_, vm) {
            return new Column(children: <Widget>[
              new MainWrapper(
                  isNavigated: isNavigated,
                  i18n: i18n,
                  isProMode: isProMode,
                  isLoggedIn: isLoggedIn)
            ]);
          }),
    );
  }
}

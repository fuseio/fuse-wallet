import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/views/splash.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:peepl/redux/actions/user_actions.dart';
import 'package:peepl/redux/state/store.dart';
import 'package:peepl/screens/pro_routes.gr.dart';
import 'package:peepl/screens/routes.gr.dart';
import 'package:peepl/themes/app_theme.dart';
import 'package:peepl/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env_peepl');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runZonedGuarded<Future<void>>(() async => runApp(await customThemeApp()),
      (Object error, StackTrace stackTrace) async {
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

bool checkIsLoggedIn(Store<AppState> store) {
  String privateKey = store.state.userState.privateKey;
  String jwtToken = store.state.userState.jwtToken;
  bool isLoggedOut = store.state.userState.isLoggedOut;
  if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
    return true;
  }
  return false;
}

Future<CustomTheme> customThemeApp() async {
  Store<AppState> store = await AppFactory().getStore();

  String initialRoute = checkIsLoggedIn(store) ? Router.cashHomeScreen : Router.splashScreen;

  return CustomTheme(
    initialThemeKey: MyThemeKeys.DEFAULT,
    child: new MyApp(store: store, initialRoute: initialRoute),
  );
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  final String initialRoute;
  MyApp({Key key, this.store, this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final i18n = I18n.delegate;
  bool isProMode = false;

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

  onWillChange(prevVM, nextVM) {
    if (prevVM.isProMode != nextVM.isProMode) {
      setState(() {
        isProMode = nextVM.isProMode;
      });
    }
  }

  onInit(Store<AppState> store) {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
      store.dispatch(getWalletAddressessCall());
      store.dispatch(identifyCall());
      store.dispatch(loadContacts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: widget.store,
      child: new StoreConnector<AppState, SplashViewModel>(
          converter: SplashViewModel.fromStore,
          onWillChange: onWillChange,
          onInit: onInit,
          builder: (_, vm) {
            return new Column(children: <Widget>[
              Expanded(
                  child: MaterialApp(
                title: 'Peepl wallet',
                initialRoute: isProMode
                    ? ProRouter.proModeHomeScreen
                    : widget.initialRoute,
                navigatorKey:
                    isProMode ? ProRouter.navigator.key : Router.navigator.key,
                onGenerateRoute: isProMode
                    ? ProRouter.onGenerateRoute
                    : Router.onGenerateRoute,
                theme: CustomTheme.of(context),
                localizationsDelegates: [
                  i18n,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: i18n.supportedLocales,
                localeResolutionCallback:
                    i18n.resolution(fallback: new Locale("en", "US")),
                navigatorObservers: [SegmentObserver()],
              ))
            ]);
          }),
    );
  }
}

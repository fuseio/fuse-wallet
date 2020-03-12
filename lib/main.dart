import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/splash.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String configFile = String.fromEnvironment('CONFIG_FILE', defaultValue: '.env_prod');
  await DotEnv().load(configFile);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runZoned<Future<void>>(
    () async => runApp(await customThemeApp()),
    onError: (Object error, StackTrace stackTrace) async {
      try {
        await AppFactory().reportError(error, stackTrace);
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
    }
  );

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

  onInit(store) {
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    String communityManager = store.state.cashWalletState.communityManagerAddress;
    String transferManager = store.state.cashWalletState.transferManagerAddress;
    if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
      store.dispatch(getWalletAddressessCall(communityManager: communityManager, transferManager: transferManager));
      store.dispatch(identifyCall());
      Router.navigator.pushNamedAndRemoveUntil(Router.cashHomeScreen, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));
    return new StoreProvider<AppState>(
      store: store,
      child: new StoreConnector<AppState, SplashViewModel>(
          onInit: onInit,
          converter: SplashViewModel.fromStore,
          builder: (_, vm) {
            return new Column(
              children: <Widget>[
                new Expanded(
                  child: MaterialApp(
                  title: 'Fuse Cash',
                  initialRoute: Router.splashScreen,
                  navigatorKey: Router.navigator.key,
                  onGenerateRoute: Router.onGenerateRoute,
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
    // return
  }
}

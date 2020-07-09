import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/route_guards.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');
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
  return CustomTheme(
    initialThemeKey: MyThemeKeys.DEFAULT,
    child: new MyApp(store: store, isLoggedIn: checkIsLoggedIn(store)),
  );
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  final bool isLoggedIn;
  MyApp({Key key, this.store, this.isLoggedIn}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'Fuse Cash',
          onGenerateRoute: Router(),
          builder: (ctx, nav) => ExtendedNavigator(
            name: 'root',
            router: Router(),
            guards: [AuthGuard(isLoggedIn: widget.isLoggedIn)],
          ),
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
        ));
    // return StoreProvider<AppState>(
    //     store: widget.store,
    //     child: MaterialApp(
    //       title: 'Fuse Cash',
    //       initialRoute: widget.initialRoute,
    //       navigatorKey: Router.navigator.key,
    //       onGenerateRoute: Router.onGenerateRoute,
    //       theme: CustomTheme.of(context),
    //       localizationsDelegates: [
    //         i18n,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //       ],
    //       supportedLocales: i18n.supportedLocales,
    //       localeResolutionCallback:
    //           i18n.resolution(fallback: new Locale("en", "US")),
    //       navigatorObservers: [SegmentObserver()],
    //     ));
  }
}

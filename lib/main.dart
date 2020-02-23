import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/routes.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

void main() async {
  String configFile = String.fromEnvironment('CONFIG_FILE', defaultValue: '.env_qa');
  print('loading $configFile config file');
  await DotEnv().load(configFile);
  SentryClient sentry = await AppFactory().getSentry();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) async {
    runZoned<Future<void>>(
      () async => runApp(CustomTheme(
        initialThemeKey: MyThemeKeys.DEFAULT,
        child: new MyApp(
            store: await AppFactory().getStore(),
        ),
      )),
      onError: (Object error, StackTrace stackTrace) async {
        try {
          await AppFactory().reportError(error, stackTrace);
        } catch (e) {
          print('Sending report to sentry.io failed: $e');
          print('Original error: $error');
        }
      }
    );
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new StoreProvider<AppState>(
            store: store,
            child: new MaterialApp(
              title: 'Fuse Cash',
              initialRoute: '/',
              routes: getRoutes(),
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
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/routes.dart';
import 'dart:core';
import 'package:fusecash/themes/app_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(new MyApp(
    store: await createReduxStore(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.store}) : super(key: key);
  Store<AppState> store;

  @override
  _MyAppState createState() => _MyAppState(store);
}

class _MyAppState extends State<MyApp> {
  Store<AppState> store;
 _MyAppState(this. store);

  final i18n = I18n.delegate;
  
  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    //_newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    I18n.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark
    ));
    //I18n.onLocaleChanged = onLocaleChange;

    return new Column(
      children: <Widget>[
        new Expanded(
          child: new StoreProvider<AppState> (
            store: store,
            child: new MaterialApp(
              title: 'Fuse Cash',
              initialRoute: '/',
              routes: getRoutes(),
              theme: getTheme(),
              localizationsDelegates: [
                i18n,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: i18n.supportedLocales,
              localeResolutionCallback: i18n.resolution(fallback: new Locale("en", "US")),
              ),
          ),
        ),
      ],
    );
  }
}

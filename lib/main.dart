import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/redux/state/app_state.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'dart:core';
import 'package:fusecash/themes/app_theme.dart';
import 'package:redux/redux.dart';
import 'redux/reducers/app_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'redux/state/state_secure_storage.dart';
import 'screens/cash_home.dart/cash_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = new FlutterSecureStorage();
  final persistor = Persistor<AppState>(
    //storage: FlutterStorage(key: "app6"),
    storage: SecureStorage(storage= storage),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  var initialState;
  try {
    initialState = await persistor.load();
  }
  catch (e) {
    print(e);
    initialState = null;
  }
  
  final store = Store<AppState>(
      appReducer,
      initialState: initialState ?? new AppState.initial(),
      middleware: [thunkMiddleware, persistor.createMiddleware()]
  );
  
  runApp(new MyApp(
    store: store,
  ));
}

//void main() => runApp(MyApp());

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

  /*
  final Store<AppState> store = Store<AppState>(
    appReducer, /* Function defined in the reducers file */
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  );
  */
  
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
    

    //I18n.onLocaleChanged = onLocaleChange;

    return new Column(
      children: <Widget>[
        new Expanded(
          child: new StoreProvider<AppState> (
            store: store,
            child: new MaterialApp(
              title: 'Fuse Cash',
              initialRoute: '/',
              routes: {
                '/': (context) => SplashScreen(),
                '/cash': (context) => CashHomeScreen(),
              },
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

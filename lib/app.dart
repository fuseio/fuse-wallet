import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux/redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp(this.store);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late StreamSubscription<Map> streamSubscription;
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setJwtToken(Store<AppState> store) {
    final String jwtToken = store.state.userState.jwtToken;
    if (![null, ''].contains(jwtToken)) {
      isAuthenticated = true;
      log.info('JWT: $jwtToken');
      api.setJwtToken(jwtToken);
    }
  }

  @override
  void initState() {
    super.initState();
    setJwtToken(widget.store);
    _locale = widget.store.state.userState.locale;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp.router(
        locale: _locale,
        title: Strings.APP_NAME,
        themeMode: ThemeMode.system,
        routeInformationParser: rootRouter.defaultRouteParser(),
        theme: FlexColorScheme.light(
          fontFamily: 'Europa',
          colors: FlexSchemeColor.from(
            secondary: Color(0xFFF5F5F5),
            secondaryVariant: Color(0xFF777777),
            primary: Color(0xFF2A8FB5),
            primaryVariant: Color(0xFF0E2373),
            appBarColor: Color(0xFFFFFFFF),
          ),
        ).toTheme,
        routerDelegate: rootRouter.delegate(
          navigatorObservers: () => [
            AutoRouteObserver(),
            SentryNavigatorObserver(),
          ],
        ),
        builder: (_, router) => ResponsiveWrapper.builder(
          router!,
          maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        localizationsDelegates: [
          I10n.delegate,
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocaleNamesLocalizationsDelegate(),
        ],
        supportedLocales: I10n.delegate.supportedLocales,
        localeListResolutionCallback: (locales, supportedLocales) {
          for (Locale locale in locales!) {
            if (supportedLocales.contains(locale)) {
              return locale;
            }
          }
          return Locale('en', 'US');
        },
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}

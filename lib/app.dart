import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:app_links/app_links.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/store.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/wallet_connect.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  StreamSubscription<Uri>? _linkSubscription;

  void clearSecureStorageOnReinstall() async {
    String key = 'first_run';
    final prefs = getIt<SharedPreferences>();
    if ((prefs.getBool(key) ?? true)) {
      Analytics.track(
        eventName: AnalyticsEvents.applicationInstalled,
      );
      prefs.setBool(key, false);
    }
    Analytics.track(
      eventName: AnalyticsEvents.applicationOpened,
    );
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  void setJwtToken() {
    final String jwtToken =
        getIt<ReduxService>().store.state.userState.jwtToken;
    if (jwtToken.isNotEmpty) {
      final prefs = getIt<SharedPreferences>();
      prefs.setBool('first_run', false);
      chargeApi.setJwtToken(jwtToken);
    }
  }

  void initDeepLinks() async {
    final AppLinks appLinks = AppLinks();
    final Uri? url = await appLinks.getInitialAppLink();
    final String wcDeepLink = Uri.decodeFull(url.toString());
    wcURIParser(wcDeepLink);
    _linkSubscription = appLinks.uriLinkStream.listen((url) {
      final String wcDeepLink = Uri.decodeFull(url.toString());
      wcURIParser(wcDeepLink);
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() {
    _requestATTPermission();
    clearSecureStorageOnReinstall();
    setJwtToken();
    _locale = getIt<ReduxService>().store.state.userState.locale;
    initDeepLinks();
  }

  void _requestATTPermission() {
    if (Platform.isIOS) {
      AppTrackingTransparency.requestTrackingAuthorization()
          .then((status) async {
        if (status == TrackingStatus.authorized) {
          await AppTrackingTransparency.getAdvertisingIdentifier();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return StoreProvider<AppState>(
            store: getIt<ReduxService>().store,
            child: GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: Center(
                child: SpinKitDancingSquare(
                  color: flexThemeData.toTheme.colorScheme.primary,
                  size: 50.0,
                ),
              ),
              overlayOpacity: 0.8,
              child: MaterialApp.router(
                locale: _locale,
                title: Strings.appTitle,
                themeMode: ThemeMode.system,
                routeInformationParser:
                    getIt<RootRouter>().defaultRouteParser(),
                theme: flexThemeData.toTheme,
                routerDelegate: getIt<RootRouter>().delegate(
                  navigatorObservers: () => [
                    AutoRouteObserver(),
                    FirebaseAnalyticsObserver(
                      analytics: getIt<FirebaseAnalytics>(),
                    ),
                  ],
                ),
                builder: (_, router) => ResponsiveWrapper.builder(
                  router!,
                  maxWidth: 1200,
                  minWidth: 400,
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                    ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                  ],
                ),
                localizationsDelegates: const [
                  LocaleNamesLocalizationsDelegate(),
                  CountryLocalizations.delegate,
                  ...I10n.localizationsDelegates,
                ],
                supportedLocales: I10n.supportedLocales,
                localeListResolutionCallback: (locales, supportedLocales) {
                  for (Locale locale in locales!) {
                    if (supportedLocales.contains(locale)) {
                      return locale;
                    }
                  }
                  return const Locale('en', 'US');
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
            ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: flexThemeData.toTheme.colorScheme.primary,
              body: Center(
                child: Image.asset(
                  'assets/images/pincode_logo.png',
                  width: 71,
                  height: 61,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:advertising_id/advertising_id.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/di/di.dart';
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
  late AppsflyerSdk _appsflyerSdk;
  late StreamSubscription<Map> streamSubscription;
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

  void listenDynamicLinks(Store<AppState> store) {
    streamSubscription = FlutterBranchSdk.initSession().listen((
      Map<dynamic, dynamic> linkData,
    ) {
      if (linkData["~channel"] == "Facebook") {
        Segment.track(
          eventName: 'New user from campaign',
          properties: {
            'source': linkData["~channel"],
            ...linkData,
          },
        );
      }
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setJwtToken(widget.store);
    listenDynamicLinks(widget.store);
    _locale = widget.store.state.userState.locale;
    final AppsFlyerOptions options = AppsFlyerOptions(
      afDevKey: dotenv.env['APPS_FLYER_DEV_KEY']!,
      appId: '1559937899',
      showDebug: kDebugMode,
      timeToWaitForATTUserAuthorization: 120,
    );
    _appsflyerSdk = AppsflyerSdk(options);
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (Platform.isAndroid) {
        final String? advertisingId = await AdvertisingId.id(true);
        if (advertisingId != null) {
          _appsflyerSdk.setAndroidIdData(advertisingId);
        }
      }
    });
    _appsflyerSdk.enableFacebookDeferredApplinks(true);
    _appsflyerSdk.onAppOpenAttribution((res) {
      log.info("onAppOpenAttribution res: " + res.toString());
    });
    _appsflyerSdk.onInstallConversionData((res) {
      log.info("onInstallConversionData res: " + res.toString());
      if (res['status'] == 'success') {
        final bool isFirstTime = res['payload']['is_first_launch'] ?? false;
        final String? campaign = res['payload']['campaign'];
        if (isFirstTime &&
            campaign != null &&
            campaign.toLowerCase() == 'facebook') {
          Segment.track(
            eventName: 'New user from campaign',
            properties: {
              ...res,
            },
          );
        }
      }
    });
    _appsflyerSdk.onDeepLinking((res) {
      log.info("onDeepLinking res: " + res.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _appsflyerSdk.initSdk(
          registerConversionDataCallback: true,
          registerOnAppOpenAttributionCallback: true,
          registerOnDeepLinkingCallback: true,
        ),
        getIt.allReady(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
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
                  primary: Color(0xFF38D989),
                  primaryVariant: Color(0xFF23B16A),
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
                LocaleNamesLocalizationsDelegate(),
                I10n.delegate,
                CountryLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
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
        } else {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Color(0xFF38D989),
              body: Center(
                child: Image.asset(
                  'assets/images/splash.png',
                  width: 85,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

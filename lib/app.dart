import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
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

  void listenDynamicLinks(Store<AppState> store) async {
    streamSubscription =
        FlutterBranchSdk.initSession().listen((linkData) async {
      log.info("branch listening.");
      store.dispatch(BranchListening());
      log.info("Got link data: ${linkData.toString()}");
      if (linkData["~feature"] == "switch_community") {
        final String communityAddress = linkData['community_address'];
        log.info("communityAddress $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(
          segmentIdentifyCall(
            Map<String, dynamic>.from({
              'Referral': linkData["~feature"],
              'Referral link': linkData['~referring_link']
            }),
          ),
        );
        Segment.track(
          eventName: 'Wallet: Branch: Studio Invite',
          properties: Map<String, dynamic>.from(linkData),
        );
      }
      if (linkData["~feature"] == "invite_user") {
        final String communityAddress = linkData["community_address"];
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(
          segmentIdentifyCall(
            Map<String, dynamic>.from({
              'Referral': linkData["~feature"],
              'Referral link': linkData['~referring_link']
            }),
          ),
        );
        Segment.track(
          eventName: 'Wallet: Branch: User Invite',
          properties: Map<String, dynamic>.from(linkData),
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return StoreProvider<AppState>(
            store: widget.store,
            child: MaterialApp.router(
              locale: _locale,
              title: Strings.APP_NAME,
              themeMode: ThemeMode.system,
              routeInformationParser: rootRouter.defaultRouteParser(),
              theme: flexColorSchemeLight.toTheme,
              routerDelegate: rootRouter.delegate(
                navigatorObservers: () => [
                  AutoRouteObserver(),
                  SentryNavigatorObserver(),
                ],
              ),
              debugShowCheckedModeBanner: false,
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
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ///todo: should the colors here needs to be switched?
                      Color(0xFFB1FDC0),
                      Color(0xFFE6FD99),
                      Color(0xFFFEFD86)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/pincode_logo.png',
                    width: 71,
                    height: 61,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

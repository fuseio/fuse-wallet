import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({Key key, this.store}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<Map> streamSubscription;
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setJwtToken(Store<AppState> store) async {
    String jwtToken = store?.state?.userState?.jwtToken;
    if (![null, ''].contains(jwtToken)) {
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
        var communityAddress = linkData["community_address"];
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
        store.dispatch(
          segmentTrackCall(
            "Wallet: Branch: Studio Invite",
            properties: Map<String, dynamic>.from(linkData),
          ),
        );
      }
      if (linkData["~feature"] == "invite_user") {
        var communityAddress = linkData["community_address"];
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(
          segmentIdentifyCall(
            Map<String, dynamic>.from({
              'Referral': linkData["~feature"],
              'Referral link': linkData['~referring_link']
            }),
          ),
        );
        store.dispatch(
          segmentTrackCall(
            "Wallet: Branch: User Invite",
            properties: Map<String, dynamic>.from(linkData),
          ),
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
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        locale: _locale,
        themeMode: ThemeMode.system,
        title: Strings.APP_NAME,
        builder: ExtendedNavigator.builder(
          initialRoute: "/",
          router: Router(),
          guards: [AuthGuard()],
          observers: [
            FirebaseAnalyticsObserver(analytics: getIt<FirebaseAnalytics>()),
            SegmentObserver(),
            SentryNavigatorObserver(),
          ],
          builder: (_, extendedNav) => Theme(
            data: FlexColorScheme.light(
              fontFamily: 'Europa',
              colors: FlexSchemeColor.from(
                secondary: Color(0xFFF5F5F5),
                secondaryVariant: Color(0xFF777777),
                primary: Color(0xFF38D989),
                primaryVariant: Color(0xFF23B16A),
                accentColor: Color(0xFF000000),
                appBarColor: Color(0xFFFFFFFF),
              ),
            ).toTheme,
            child: ResponsiveWrapper.builder(
              extendedNav,
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
          ),
        ),
        localizationsDelegates: [
          I10n.delegate,
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: I10n.delegate.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}

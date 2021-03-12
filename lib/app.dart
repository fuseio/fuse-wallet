import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/services.dart';
// import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final i18n = I18n.delegate;
  StreamSubscription<Map> streamSubscription;

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
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
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    setJwtToken(widget.store);
    listenDynamicLinks(widget.store);
    I18n.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        themeMode: ThemeMode.system,
        title: Strings.APP_NAME,
        builder: ExtendedNavigator.builder(
          observers: [
            SegmentObserver(),
            SentryNavigatorObserver(),
          ],
          router: Router(),
          initialRoute: "/",
          guards: [AuthGuard()],
          builder: (_, extendedNav) => Theme(
            data: FlexColorScheme.light(
              fontFamily: 'Europa',
              colors: FlexSchemeColor.from(
                secondary: Color(0xFFF5F5F5),
                secondaryVariant: Color(0xFF777777),
                primary: Color(0xFF38D989),
                accentColor: Color(0xFF000000),
                appBarColor: Theme.of(context).canvasColor,
              ),
            ).toTheme,
            child: extendedNav,
          ),
        ),
        localizationsDelegates: [
          i18n,
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback: i18n.resolution(
          fallback: Locale("en", "US"),
        ),
      ),
    );
  }
}

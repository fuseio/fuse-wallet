import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:seedbed/redux/state/store.dart';
import 'package:seedbed/screens/route_guards.dart';
import 'package:seedbed/screens/routes.gr.dart';
import 'package:seedbed/themes/app_theme.dart';
import 'package:seedbed/themes/custom_theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:seedbed/generated/i18n.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('environment/.env_seedbed');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Store<AppState> store = await AppFactory().getStore();
  runZonedGuarded<Future<void>>(
      () async => runApp(CustomTheme(
            initialThemeKey: MyThemeKeys.DEFAULT,
            child: new MyApp(store: store),
          )), (Object error, StackTrace stackTrace) async {
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

  void listenDynamicLinks(Store<AppState> store) async {
    final logger = await AppFactory().getLogger('action');
    logger.info("branch listening.");
    store.dispatch(BranchListening());
    streamSubscription =
        FlutterBranchSdk.initSession().listen((linkData) async {
      logger.info("Got link data: ${linkData.toString()}");
      if (linkData["~feature"] == "switch_community") {
        var communityAddress = linkData["community_address"];
        logger.info("communityAddress $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
          'Referral': linkData["~feature"],
          'Referral link': linkData['~referring_link']
        })));
        store.dispatch(segmentTrackCall("Wallet: Branch: Studio Invite",
            properties: new Map<String, dynamic>.from(linkData)));
      }
      if (linkData["~feature"] == "invite_user") {
        var communityAddress = linkData["community_address"];
        logger.info("community_address $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
          'Referral': linkData["~feature"],
          'Referral link': linkData['~referring_link']
        })));
        store.dispatch(segmentTrackCall("Wallet: Branch: User Invite",
            properties: new Map<String, dynamic>.from(linkData)));
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print(
          'InitSession error: ${platformException.code} - ${platformException.message}');
      logger.severe('ERROR - FlutterBranchSdk initSession $error');
      store.dispatch(BranchListeningStopped());
    }, cancelOnError: true);
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    listenDynamicLinks(widget.store);
    I18n.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'Seedbed wallet',
          builder: ExtendedNavigator.builder(
            router: Router(),
            initialRoute: "/",
            guards: [AuthGuard()],
            builder: (_, extendedNav) => Theme(
              data: CustomTheme.of(context),
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
          localeResolutionCallback:
              i18n.resolution(fallback: new Locale("en", "US")),
        ));
  }
}

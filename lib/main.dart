import 'dart:async';
import 'dart:io';
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
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_segment/flutter_segment.dart';

void main() async {
  await DotEnv().load('.env_bilira');
  SentryClient sentry = await setupSentry();

  Future<void> _reportError(dynamic error, dynamic stackTrace) async {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) async {
    runZoned<Future<void>>(
      () async => runApp(CustomTheme(
        initialThemeKey: MyThemeKeys.BILIRA,
        child: new MyApp(
            store: await AppFactory().getStore(),
        ),
      )),
      onError: (Object error, StackTrace stackTrace) {
        try {
          _reportError(error, stackTrace);
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

Future<SentryClient> setupSentry() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String versionName = packageInfo.version;
  String versionCode = packageInfo.buildNumber;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Device device;
  OperatingSystem operatingSystem;
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device = new Device(
      name: androidInfo.device,
      family: androidInfo.brand,
      model: androidInfo.model,
      modelId: androidInfo.id,
      arch: androidInfo.hardware,
  //      batteryLevel: 0,
  //      orientation: null,
      manufacturer: androidInfo.manufacturer,
      brand: androidInfo.brand,
  //      screenResolution: "",
  //      screenDensity: "",
  //      screenDpi: "",
  //      online: false,
  //      charging: false,
  //      lowMemory: false,
      simulator: !androidInfo.isPhysicalDevice,
  //      memorySize: 0,
  //      freeMemory: 0,
  //      usableMemory: 0,
  //      storageSize: 0,
  //      freeStorage: 0,
  //      externalStorageSize: 0,
  //      externalFreeStorage: 0,
  //      bootTime: null,
  //      timezone: ""
    );
    operatingSystem = OperatingSystem(
        name: Platform.operatingSystem,
        version: androidInfo.version.release,
        build: androidInfo.version.incremental,
//        kernelVersion: "",
  //        rooted: false,
  //        rawDescription: ""
    );

  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    device = new Device(
      name: iosInfo.name,
      family: iosInfo.localizedModel,
      model: iosInfo.model,
      modelId: iosInfo.systemVersion,
      arch: iosInfo.utsname.machine,
  //      batteryLevel: 0,
  //      orientation: null,
      manufacturer: "Apple",
      brand: iosInfo.localizedModel,
  //      screenResolution: "",
  //      screenDensity: "",
  //      screenDpi: "",
  //      online: false,
  //      charging: false,
  //      lowMemory: false,
      simulator: !iosInfo.isPhysicalDevice,
  //      memorySize: 0,
  //      freeMemory: 0,
  //      usableMemory: 0,
  //      storageSize: 0,
  //      freeStorage: 0,
  //      externalStorageSize: 0,
  //      externalFreeStorage: 0,
  //      bootTime: null,
  //      timezone: ""
    );

    operatingSystem = OperatingSystem(
      name: iosInfo.utsname.sysname,
      version: iosInfo.utsname.version,
      build: iosInfo.utsname.release,
      kernelVersion: iosInfo.utsname.machine,
  //        rooted: false,
  //        rawDescription: ""
    );
  }

  final SentryClient sentry = new SentryClient(
      dsn: DotEnv().env['SENTRY_DSN'],
      environmentAttributes: new Event(
        serverName: DotEnv().env['API_BASE_URL'],
        release: versionName + ":" + versionCode,
        environment: DotEnv().env['MODE'],
        contexts: new Contexts(
          device: device,
          operatingSystem: operatingSystem
        ),
        userContext: new User(
            id: await FlutterSegment.getAnonymousId,
        )
      )
  );
  return sentry;
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

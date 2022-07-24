import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fusecash/app.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await dotenv.load(fileName: 'environment/.env');
    await configureDependencies();
    getIt<FirebasePerformance>().setPerformanceCollectionEnabled(
      !kDebugMode,
    );
    getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(
      !kDebugMode,
    );
    FlutterError.onError = getIt<FirebaseCrashlytics>().recordFlutterError;
    runApp(const MyApp());
  }, (exception, stackTrace) {
    if (kDebugMode) {
      print('FlutterError exception: ${exception.toString()}');
      print('FlutterError stackTrace: ${stackTrace.toString()}');
    } else {
      getIt<FirebaseCrashlytics>().recordError(
        exception,
        stackTrace,
        fatal: true,
      );
    }
  });
}

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:fusecash/utils/remote_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @preResolve
  Future<RemoteConfigService> get remoteConfigService =>
      RemoteConfigService.getInstance();

  @lazySingleton
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  @lazySingleton
  FirebasePerformance get firebasePerformance => FirebasePerformance.instance;

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @lazySingleton
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;
}

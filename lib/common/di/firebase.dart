import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @injectable
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics();

  @preResolve
  Future<FirebaseApp> get firebaseApp => Firebase.initializeApp();
}

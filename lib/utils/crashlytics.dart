import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fusecash/common/di/di.dart';

class Crashlytics {
  static void recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
  }) {
    getIt<FirebaseCrashlytics>().recordError(
      exception,
      stack,
      reason: reason,
    );
  }

  static void logMessage(
    String message,
  ) {
    getIt<FirebaseCrashlytics>().log(
      message,
    );
  }
}

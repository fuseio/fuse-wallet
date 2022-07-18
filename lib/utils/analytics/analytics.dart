import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:fusecash/common/di/di.dart';

class Analytics {
  static Future<void> track({
    required String eventName,
    Map<String, dynamic>? properties,
  }) async {
    getIt<FirebaseAnalytics>().logEvent(
      name: eventName,
      parameters: properties,
    );
  }

  static Future<void> setUserId(String userId) async {
    getIt<FirebaseAnalytics>().setUserId(id: userId);
  }

  static Future<void> identify(
    Map<String, dynamic> properties,
  ) async {
    properties.forEach((key, value) {
      getIt<FirebaseAnalytics>().setUserProperty(
        name: key,
        value: value.toString(),
      );
    });
  }
}

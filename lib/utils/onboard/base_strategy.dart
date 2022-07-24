import 'package:flutter/material.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/utils/onboard/firebase.dart';
import 'package:fusecash/utils/onboard/simple.dart';
import 'package:fusecash/utils/onboard/sms.dart';

abstract class IOnBoardStrategy {
  final OnboardStrategy strategy;
  IOnBoardStrategy(this.strategy);

  Future<dynamic> login(
    store,
    phoneNumber,
    VoidCallback onSuccess,
    Function(dynamic error) onError,
  );
  Future<dynamic> verify(store, verificationCode, onSuccess);
}

class OnBoardStrategyFactory {
  static IOnBoardStrategy create(String strategy) {
    if (strategy == 'firebase') {
      return FirebaseStrategy();
    } else if (strategy == 'sms') {
      return SmsStrategy();
    } else {
      return SimpleStrategy();
    }
  }
}

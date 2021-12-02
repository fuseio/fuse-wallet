import 'package:flutter/material.dart';
import 'package:supervecina/constants/enums.dart';
import 'package:supervecina/utils/onboard/firebase.dart';
import 'package:supervecina/utils/onboard/simple.dart';
import 'package:supervecina/utils/onboard/sms.dart';

abstract class IOnBoardStrategy {
  final OnboardStrategy strategy;

  Future<dynamic> login(
    store,
    phoneNumber,
    VoidCallback onSuccess,
    Function(dynamic error) onError,
  );
  Future<dynamic> verify(store, verificationCode, onSuccess);

  IOnBoardStrategy(this.strategy);
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

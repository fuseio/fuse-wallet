import 'package:flutter/material.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/models/tokens/token.dart';

class SendFlowArguments {
  late String? name;
  final bool isMultiBridge;
  late String? phoneNumber;
  late String? accountAddress;
  late double? amount;
  late ImageProvider? avatar;
  late SendType? sendType;
  late Token? tokenToSend;
  late final bool useBridge;

  SendFlowArguments({
    this.sendType,
    this.useBridge = false,
    this.tokenToSend,
    this.name,
    this.phoneNumber,
    this.isMultiBridge = false,
    this.accountAddress,
    this.amount,
    this.avatar,
  });
}

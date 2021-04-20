import 'package:flutter/material.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/models/tokens/token.dart';

class SendFlowArguments {
  String name;
  final bool isMultiBridge;
  String phoneNumber;
  String accountAddress;
  double amount;
  ImageProvider avatar;
  SendType sendType;
  Token tokenToSend;
  final bool useBridge;

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

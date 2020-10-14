import 'package:flutter/material.dart';
import 'package:straitsx/models/tokens/token.dart';

enum SendType {
  CONTACT,
  BUSINESS,
  QR_ADDRESS,
  FUSE_ADDRESS,
  PASTED_ADDRESS,
  ETHEREUM_ADDRESS
}

class SendAmountArguments {
  String name;
  final bool isMultiBridge;
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar = AssetImage('assets/images/anom.png');
  SendType sendType;
  Token tokenToSend;
  final bool useBridge;

  SendAmountArguments(
      {this.sendType,
      this.useBridge = false,
      this.tokenToSend,
      this.name,
      this.phoneNumber,
      this.isMultiBridge = false,
      this.accountAddress,
      this.amount,
      this.avatar});
}

import 'package:flutter/material.dart';
import 'package:esol/models/tokens/token.dart';

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
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar;
  SendType sendType;
  Token tokenToSend;
  final bool useBridge;

  SendAmountArguments(
      {this.sendType,
      this.useBridge = false,
      this.tokenToSend,
      this.name,
      this.phoneNumber,
      this.accountAddress,
      this.amount,
      this.avatar});
}

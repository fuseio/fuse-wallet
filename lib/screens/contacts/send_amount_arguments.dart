import 'package:flutter/material.dart';
import 'package:seedbed/models/tokens/token.dart';

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
  final bool isConvert;

  SendAmountArguments(
      {this.sendType,
      this.tokenToSend,
      this.name,
      this.phoneNumber,
      this.accountAddress,
      this.isConvert = false,
      this.amount,
      this.avatar});
}

import 'package:flutter/material.dart';
import 'package:fc_knudde/models/tokens/token.dart';

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

  SendAmountArguments(
      {this.sendType,
      this.tokenToSend,
      this.name,
      this.phoneNumber,
      this.accountAddress,
      this.amount,
      this.avatar});
}

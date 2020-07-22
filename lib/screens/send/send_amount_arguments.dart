import 'package:flutter/material.dart';
import 'package:peepl/models/plugins/fee_base.dart';
import 'package:peepl/models/pro/token.dart';
import 'package:peepl/models/token.dart' as token;

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
  bool sendToCashMode = false;
  bool isProMode = false;
  Token erc20Token;
  token.Token tokenToSend;
  FeePlugin feePlugin;

  SendAmountArguments(
      {this.sendToCashMode = false,
      this.sendType,
      this.isProMode = false,
      this.name,
      this.phoneNumber,
      this.erc20Token,
      this.accountAddress,
      this.amount,
      this.feePlugin,
      this.avatar});
}

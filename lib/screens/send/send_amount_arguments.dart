import 'package:flutter/material.dart';
import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/models/tokens/token.dart';

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

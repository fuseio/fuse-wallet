import 'package:flutter/material.dart';

enum SendType { CONTACT, BUSINESS, QR_ADDRESS, FUSE_ADDRESS }

class SendAmountArguments {
  String name;
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar;
  SendType sendType;

  SendAmountArguments({this.sendType, this.name, this.phoneNumber, this.accountAddress, this.amount, this.avatar});
}

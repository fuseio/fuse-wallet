import 'package:flutter/material.dart';

class SendAmountArguments {
  String name;
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar;
  bool isBusiness = false;

  SendAmountArguments({this.name, this.phoneNumber, this.accountAddress, this.amount, this.avatar, this.isBusiness});
}
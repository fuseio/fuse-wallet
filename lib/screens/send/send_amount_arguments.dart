import 'package:flutter/material.dart';

class SendAmountArguments {
  String name;
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar;

  SendAmountArguments({this.name, this.phoneNumber, this.accountAddress, this.amount, this.avatar});
}
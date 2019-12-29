import 'package:flutter/material.dart';
import 'package:fusecash/models/token.dart';

class SendAmountArguments {
  Token token;
  String name;
  String phoneNumber;
  String accountAddress;
  num amount;
  ImageProvider avatar;

  SendAmountArguments({this.name, this.token, this.phoneNumber, this.accountAddress, this.amount, this.avatar});
}
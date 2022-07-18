import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';

import 'package:fusecash/models/tokens/token.dart';

class SendFlowArguments {
  String? name;
  String? phoneNumber;
  String? accountAddress;
  String? amount;
  ImageProvider? avatar;
  Token? tokenToSend;
  Collectible? collectible;

  SendFlowArguments({
    this.tokenToSend,
    this.name,
    this.phoneNumber,
    this.accountAddress,
    this.amount,
    this.avatar,
    this.collectible,
  });
}

import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

abstract class ERC20Token extends Equatable {
  final String address;
  final String name;
  final String symbol;
  final int decimals;
  final BigInt amount;

  @override
  List<Object> get props => [amount, name, symbol];

  ERC20Token({
    this.address,
    this.name,
    this.symbol,
    this.decimals,
    this.amount,
  });

  String getBalance() {
    double formatedValue = this.amount / BigInt.from(pow(10, decimals));
    Decimal decimalValue = Decimal.parse(formatedValue.toString());
    return decimalValue.isInteger
        ? decimalValue.toString()
        : decimalValue.toStringAsFixed(2);
  }

  Future<dynamic> fetchTokenBalance(String walletAddress,
      {void Function(BigInt) onDone,
      void Function(Object error, StackTrace stackTrace) onError});

  Map<String, dynamic> toJson() => {
        'address': this.address,
        'name': this.name,
        'symbol': this.symbol,
        'decimals': this.decimals,
        'amount': this.amount?.toString(),
      };
}

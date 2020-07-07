import 'dart:math';

import 'package:decimal/decimal.dart';

final Map prices = {
  "DZAR": 0.0533,
  "DAI": 0.9955,
  "USDT": 0.9999,
  "USDC": 1.0009,
  "IDRT": 0.0132146,
  "EURS": 1.0995,
  "TUSD": 1.0021,
};

String formatValue(BigInt value, int decimals,
    {int fractionDigits = 2, bool withPrecision = true}) {
  if (value == null || decimals == null) return '0';
  double formatedValue = value / BigInt.from(pow(10, decimals));
  if (!withPrecision) return formatedValue.toString();
  Decimal decimalValue = Decimal.parse(formatedValue.toString());
  return num.parse(decimalValue.toString()).compareTo(num.parse('0.01')) != 1
      ? decimalValue.toStringAsFixed(1)
      : decimalValue.isInteger
          ? decimalValue.toString()
          : decimalValue.toStringAsPrecision(2);
}

String getDollarValue(BigInt value, int decimals, double price,
    {bool withPrecision = false}) {
  if (value == null || decimals == null) return '0';
  double formatedValue = (value / BigInt.from(pow(10, decimals)));
  Decimal decimalValue = Decimal.parse((formatedValue * price).toString());
  if (withPrecision) return decimalValue.toString();
  return num.parse(decimalValue.toString()).compareTo(num.parse('0.01')) != 1
      ? decimalValue.toStringAsFixed(1)
      : decimalValue.isInteger
          ? decimalValue.toString()
          : decimalValue.toStringAsPrecision(2);
}

String formatAddress(String address) {
  if (address == null || address.isEmpty) return null;
  return '${address.substring(0, 6)}...${address.substring(address.length - 4, address.length)}';
}

BigInt toBigInt(dynamic value, int decimals) {
  if (value == null || decimals == null) return BigInt.zero;
  Decimal tokensAmountDecimal = Decimal.parse(value.toString());
  Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
  return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
}

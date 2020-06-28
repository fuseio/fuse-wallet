import 'dart:math';

import 'package:decimal/decimal.dart';

String formatValue(BigInt value, int decimals,
    {int fractionDigits = 2, bool withPrecision = true}) {
  if (value == null || decimals == null) return '';
  double formatedValue = value / BigInt.from(pow(10, decimals));
  if (!withPrecision) return formatedValue.toString();
  Decimal decimalValue = Decimal.parse(formatedValue.toString());
  return decimalValue.isInteger
      ? decimalValue.toString()
      : decimalValue.toStringAsFixed(2);
}

String calcValueInDollar(BigInt value, int decimals) {
  if (value == null || decimals == null) return '';
  double formatedValue1 = (value / BigInt.from(pow(10, decimals)) / 100);
  Decimal decimalValue = Decimal.parse(formatedValue1.toString());
  return decimalValue.isInteger
      ? decimalValue.toString()
      : decimalValue.toStringAsFixed(2);
}

String getDollarValue(BigInt value, int decimals, double price) {
  if (value == null || decimals == null) return '';
  double formatedValue1 = (value / BigInt.from(pow(10, decimals)));
  Decimal decimalValue = Decimal.parse((formatedValue1 * price).toString());
  return decimalValue.isInteger
      ? decimalValue.toString()
      : decimalValue.toStringAsFixed(2);
}

String formatAddress(String address) {
  if (address == null || address.isEmpty) return null;
  return '${address.substring(0, 6)}...${address.substring(address.length - 4, address.length)}';
}

BigInt toBigInt(dynamic value, int decimals) {
  Decimal tokensAmountDecimal = Decimal.parse(value.toString());
  Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
  return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
}

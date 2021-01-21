import 'dart:math';

import 'package:decimal/decimal.dart';

final Map<String, num> fees = {
  "DZAR": 17,
  "DAI": 1,
  "USDT": 1,
  "USDC": 1,
  "IDRT": 14442.61,
  "EURS": 1,
  "TUSD": 1,
};

String reduce(dynamic formatedValue) {
  if (formatedValue == null) return '0';
  Decimal decimalValue = Decimal.parse(formatedValue.toString());
  return num.parse(decimalValue.toString()).compareTo(num.parse('0.001')) != 1
      ? decimalValue.toStringAsFixed(1)
      : decimalValue.isInteger
          ? decimalValue.toString()
          : decimalValue.precision > 9
              ? decimalValue.toStringAsFixed(2)
              : decimalValue.toString();
}

String formatValue(BigInt value, int decimals,
    {int fractionDigits = 2, bool withPrecision = false}) {
  if (value == null || decimals == null) return '0';
  double formatedValue = value / BigInt.from(pow(10, decimals));
  if (withPrecision) return formatedValue.toString();
  return reduce(formatedValue);
}

String calcValueInDollar(BigInt value, int decimals) {
  if (value == null || decimals == null) return '0';
  double formatedValue1 = (value / BigInt.from(pow(10, decimals)) / 100);
  Decimal decimalValue = Decimal.parse(formatedValue1.toString());
  return decimalValue.toStringAsFixed(1);
}

String getFiatValue(BigInt value, int decimals, double price,
    {bool withPrecision = false}) {
  if (value == null || decimals == null) return '0';
  double formatedValue = (value / BigInt.from(pow(10, decimals))) * price;
  if (withPrecision) return formatedValue.toString();
  return reduce(formatedValue);
}

String formatAddress(String address) {
  if (address == null || address.isEmpty) return '';
  return '${address.substring(0, 6)}...${address.substring(address.length - 4, address.length)}';
}

BigInt toBigInt(dynamic value, int decimals) {
  if (value == null || decimals == null) return BigInt.zero;
  Decimal tokensAmountDecimal = Decimal.parse(value.toString());
  Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
  return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
}

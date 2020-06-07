import 'dart:math';

import 'package:decimal/decimal.dart';

String formatValue(BigInt value, int decimals,
    {int fractionDigits = 2, bool showFull = true}) {
  if (value == null || decimals == null) return '';
  double formatedValue = value / BigInt.from(pow(10, decimals));
  Decimal decimalValue = Decimal.parse(formatedValue.toString());
  return decimalValue.scale > 5
      ? decimalValue.toStringAsPrecision(3)
      : decimalValue.toString();
}

String calcValueInDollar(BigInt value, int decimals) {
  if (value == null || decimals == null) return '';
  double s = (value / BigInt.from(pow(10, decimals)) / 100);
  String formatedValue;
  if (s.roundToDouble() == s) {
    formatedValue = s.round().toString();
  } else {
    formatedValue = s.toString();
  }

  List a = formatedValue.split('.');
  if (a.length > 1) {
    return s.toStringAsFixed(2);
  } else {
    return formatedValue;
  }
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

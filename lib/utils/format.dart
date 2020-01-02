import 'dart:math';

import 'package:decimal/decimal.dart';

String formatValue(BigInt value, int decimals) {
  double s = value / BigInt.from(pow(10, decimals));
  if (s.roundToDouble() == s) {
    return s.round().toString();
  } else {
    return s.toString();
  }
}

String formatAddress(String address) {
  return '${address.substring(0, 6)}...${address.substring(36, 42)}';
}


BigInt toBigInt(dynamic value, int decimals) {
  Decimal tokensAmountDecimal = Decimal.parse(value.toString());
  Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
  return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
}
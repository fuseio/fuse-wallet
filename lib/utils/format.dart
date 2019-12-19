import 'dart:math';

String formatValue(BigInt value, int decimals) {
  double s = value / BigInt.from(pow(10, decimals));
  print(s);
  if (s.roundToDouble() == s) {
    return s.round().toString();
  } else {
    return s.toString();
  }
}

String formatAddress(String address) {
  return '${address.substring(0, 6)}...${address.substring(36, 42)}';
}
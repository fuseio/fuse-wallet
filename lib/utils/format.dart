import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:number_display/number_display.dart';

final Display display = createDisplay(
  decimal: 2,
);

String calcPrice(
  BigInt value,
  int decimals,
  Price priceInfo,
) {
  final bool hasPriceInfo =
      ![null, '', '0', 0, 'NaN'].contains(priceInfo?.quote);
  if (hasPriceInfo) {
    return getFiatValue(
      value,
      decimals,
      double.parse(priceInfo.quote),
    );
  } else {
    return formatValue(value, decimals);
  }
}

final Map<String, num> fees = {
  "DZAR": 17,
  "DAI": 1,
  "USDT": 1,
  "USDC": 1,
  "IDRT": 14442.61,
  "EURS": 1,
  "TUSD": 1,
};

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return Decimal.tryParse(s) != null;
}

String formatValue(
  BigInt value,
  int decimals, {
  int fractionDigits = 2,
  bool withPrecision = false,
}) {
  if (value == null || decimals == null) return '0';
  Decimal formattedValue =
      Decimal.parse((value / BigInt.from(pow(10, decimals))).toString());
  if (withPrecision) return formattedValue.toString();
  if (formattedValue.compareTo(Decimal.zero) == 1 &&
      formattedValue.compareTo(Decimal.parse('0.01')) <= 0) {
    return '< 0.01';
  }
  return display(num.parse(formattedValue.toStringAsFixed(fractionDigits)));
}

String getFiatValue(
  BigInt value,
  int decimals,
  double price, {
  int fractionDigits = 2,
}) {
  if (value == null || decimals == null || price == null) return '0';
  Decimal formattedValue = Decimal.parse(
      ((value / BigInt.from(pow(10, decimals))) * price).toString());
  if (formattedValue.compareTo(Decimal.zero) == 1 &&
      formattedValue.compareTo(Decimal.parse('0.01')) <= 0) {
    return '< 0.01';
  }
  return display(num.parse(formattedValue.toStringAsFixed(fractionDigits)));
}

String formatAddress(String address, [int endIndex = 6]) {
  if (address == null || address.isEmpty) return '';
  return '${address.substring(0, endIndex)}...${address.substring(address.length - 4, address.length)}';
}

BigInt toBigInt(dynamic value, int decimals) {
  if (value == null || decimals == null) return BigInt.zero;
  Decimal tokensAmountDecimal = Decimal.parse(value.toString());
  Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
  return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
}

String formatTokenName(String tokenName) {
  if (tokenName.endsWith('on Fuse')) {
    List splitted = tokenName.split(" ")
      ..removeWhere((ele) => ele == 'on' || ele == 'Fuse');
    return splitted.join(" ");
  }
  return tokenName;
}

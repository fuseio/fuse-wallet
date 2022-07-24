import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

import 'package:fusecash/models/tokens/price.dart';

final NumberFormat numberFormat = NumberFormat("###,###.0#", 'en_US');

num getPercentChange(num valueNow, num value24HoursAgo) {
  final adjustedPercentChange =
      ((valueNow - value24HoursAgo) / value24HoursAgo) * 100;
  if (adjustedPercentChange.isNaN || !adjustedPercentChange.isFinite) {
    return 0;
  }
  return adjustedPercentChange;
}

class Formatter {
  static Decimal fromWei(
    BigInt value,
    int decimals,
  ) =>
      (Decimal.fromBigInt(
                value,
              ) /
              Decimal.fromBigInt(
                BigInt.from(
                  pow(10, decimals),
                ),
              ))
          .toDecimal();

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return Decimal.tryParse(s) != null;
  }

  static String padZeroIfNeeded(Decimal value) {
    final formattedValue =
        numberFormat.format(value.floor(scale: 2).toDouble());
    if (Decimal.zero.compareTo(value) == 0) {
      return formattedValue.padLeft(formattedValue.length + 1, '0');
    } else if (isSmallThan(value, 1)) {
      return formattedValue.padLeft(formattedValue.length + 1, '0');
    } else {
      return formattedValue;
    }
  }

  static bool isSmallThan(Decimal value, [num valueToCompareWith = 0.01]) {
    return num.parse(value.toString()).compareTo(valueToCompareWith) == -1;
  }

  static String smallNumbersConvertor(Decimal value) {
    if (Decimal.zero.compareTo(value) == 0) {
      return value.toString();
    } else if (isSmallThan(value)) {
      return '< 0.01';
    }
    return padZeroIfNeeded(value);
  }

  static String formatValue(
    BigInt value,
    int decimals, [
    bool withPrecision = false,
  ]) {
    Decimal formattedValue = fromWei(value, decimals);
    if (withPrecision) return formattedValue.toStringAsFixed(8);
    return smallNumbersConvertor(formattedValue);
  }

  static String amountPrinter(
    BigInt value,
    int decimals,
    Price? priceInfo, [
    bool withPrecision = false,
  ]) {
    if (priceInfo != null && priceInfo.hasPriceInfo) {
      return '\$${formatValueToFiat(
        value,
        decimals,
        double.parse(priceInfo.quote),
        withPrecision,
      )}';
    } else {
      return formatValue(
        value,
        decimals,
        withPrecision,
      );
    }
  }

  static String formatValueToFiat(
    BigInt value,
    int decimals,
    double price, [
    bool withPrecision = false,
  ]) {
    Decimal formattedValue =
        fromWei(value, decimals) * Decimal.parse(price.toString());
    if (withPrecision) return formattedValue.toStringAsFixed(8);
    return smallNumbersConvertor(formattedValue);
  }

  static String formatEthAddress(String? address, [int endIndex = 6]) {
    if (address == null || address.isEmpty) return '';
    return '${address.substring(0, endIndex)}...${address.substring(address.length - 4, address.length)}';
  }

  static BigInt toBigInt(dynamic value, int? decimals) {
    if (value == null || decimals == null) return BigInt.zero;
    Decimal tokensAmountDecimal = Decimal.parse(value.toString());
    Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
    return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
  }

  static String formatTokenName(String tokenName) {
    if (tokenName.endsWith('on Fuse')) {
      List splitted = tokenName.split(" ")
        ..removeWhere((ele) => ele == 'on' || ele == 'Fuse');
      return splitted.join(" ");
    }
    return tokenName;
  }
}

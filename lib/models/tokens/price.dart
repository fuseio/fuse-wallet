import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fusecash/utils/format.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
class Price with _$Price {
  const Price._();

  factory Price({
    @Default('usd') String currency,
    @Default('0') String quote,
  }) = _Price;

  bool get hasPriceInfo => Formatter.isNumeric(quote);

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

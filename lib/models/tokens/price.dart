import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/utils/format.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@immutable
@freezed
class Price with _$Price {
  const Price._();

  @JsonSerializable()
  factory Price({
    @Default('usd') String currency,
    @Default('0') String quote,
  }) = _Price;

  String get quoteHuman => Formatter.isSmallThan(Decimal.parse(quote))
      ? display6(Decimal.parse(quote).toDouble())
      : display4(Decimal.parse(quote).toDouble());

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

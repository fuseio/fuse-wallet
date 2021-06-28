import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@immutable
@freezed
class Price with _$Price {
  @JsonSerializable()
  factory Price({
    @Default('usd') String currency,
    @Default('0') String quote,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

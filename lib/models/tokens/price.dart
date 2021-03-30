import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@immutable
@freezed
abstract class Price with _$Price {
  @JsonSerializable()
  factory Price({
    String currency,
    String quote,
    String total,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

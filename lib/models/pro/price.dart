import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable(explicitToJson: true)
class Price {
  final String currency;
  final String quote;
  final String total;

  Price copyWith({
    String currency,
    String quote,
    String total,
  }) {
    return Price(
        total: total ?? this.total,
        quote: quote ?? this.quote,
        currency: currency ?? this.currency);
  }

  Price({this.currency, this.quote, this.total});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

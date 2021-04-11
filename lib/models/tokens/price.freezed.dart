// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
class _$PriceTearOff {
  const _$PriceTearOff();

// ignore: unused_element
  _Price call({String currency, String quote, String total}) {
    return _Price(
      currency: currency,
      quote: quote,
      total: total,
    );
  }

// ignore: unused_element
  Price fromJson(Map<String, Object> json) {
    return Price.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Price = _$PriceTearOff();

/// @nodoc
mixin _$Price {
  String get currency;
  String get quote;
  String get total;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $PriceCopyWith<Price> get copyWith;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res>;
  $Res call({String currency, String quote, String total});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res> implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  final Price _value;
  // ignore: unused_field
  final $Res Function(Price) _then;

  @override
  $Res call({
    Object currency = freezed,
    Object quote = freezed,
    Object total = freezed,
  }) {
    return _then(_value.copyWith(
      currency: currency == freezed ? _value.currency : currency as String,
      quote: quote == freezed ? _value.quote : quote as String,
      total: total == freezed ? _value.total : total as String,
    ));
  }
}

/// @nodoc
abstract class _$PriceCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$PriceCopyWith(_Price value, $Res Function(_Price) then) =
      __$PriceCopyWithImpl<$Res>;
  @override
  $Res call({String currency, String quote, String total});
}

/// @nodoc
class __$PriceCopyWithImpl<$Res> extends _$PriceCopyWithImpl<$Res>
    implements _$PriceCopyWith<$Res> {
  __$PriceCopyWithImpl(_Price _value, $Res Function(_Price) _then)
      : super(_value, (v) => _then(v as _Price));

  @override
  _Price get _value => super._value as _Price;

  @override
  $Res call({
    Object currency = freezed,
    Object quote = freezed,
    Object total = freezed,
  }) {
    return _then(_Price(
      currency: currency == freezed ? _value.currency : currency as String,
      quote: quote == freezed ? _value.quote : quote as String,
      total: total == freezed ? _value.total : total as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Price implements _Price {
  _$_Price({this.currency, this.quote, this.total});

  factory _$_Price.fromJson(Map<String, dynamic> json) =>
      _$_$_PriceFromJson(json);

  @override
  final String currency;
  @override
  final String quote;
  @override
  final String total;

  @override
  String toString() {
    return 'Price(currency: $currency, quote: $quote, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Price &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.quote, quote) ||
                const DeepCollectionEquality().equals(other.quote, quote)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(quote) ^
      const DeepCollectionEquality().hash(total);

  @JsonKey(ignore: true)
  @override
  _$PriceCopyWith<_Price> get copyWith =>
      __$PriceCopyWithImpl<_Price>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PriceToJson(this);
  }
}

abstract class _Price implements Price {
  factory _Price({String currency, String quote, String total}) = _$_Price;

  factory _Price.fromJson(Map<String, dynamic> json) = _$_Price.fromJson;

  @override
  String get currency;
  @override
  String get quote;
  @override
  String get total;
  @override
  @JsonKey(ignore: true)
  _$PriceCopyWith<_Price> get copyWith;
}

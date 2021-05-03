// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Stats _$StatsFromJson(Map<String, dynamic> json) {
  return _Stats.fromJson(json);
}

/// @nodoc
class _$StatsTearOff {
  const _$StatsTearOff();

// ignore: unused_element
  _Stats call({String volume, String price, int timestamp, DateTime date}) {
    return _Stats(
      volume: volume,
      price: price,
      timestamp: timestamp,
      date: date,
    );
  }

// ignore: unused_element
  Stats fromJson(Map<String, Object> json) {
    return Stats.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Stats = _$StatsTearOff();

/// @nodoc
mixin _$Stats {
  String get volume;
  String get price;
  int get timestamp;
  DateTime get date;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $StatsCopyWith<Stats> get copyWith;
}

/// @nodoc
abstract class $StatsCopyWith<$Res> {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) then) =
      _$StatsCopyWithImpl<$Res>;
  $Res call({String volume, String price, int timestamp, DateTime date});
}

/// @nodoc
class _$StatsCopyWithImpl<$Res> implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._value, this._then);

  final Stats _value;
  // ignore: unused_field
  final $Res Function(Stats) _then;

  @override
  $Res call({
    Object volume = freezed,
    Object price = freezed,
    Object timestamp = freezed,
    Object date = freezed,
  }) {
    return _then(_value.copyWith(
      volume: volume == freezed ? _value.volume : volume as String,
      price: price == freezed ? _value.price : price as String,
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      date: date == freezed ? _value.date : date as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$StatsCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$StatsCopyWith(_Stats value, $Res Function(_Stats) then) =
      __$StatsCopyWithImpl<$Res>;
  @override
  $Res call({String volume, String price, int timestamp, DateTime date});
}

/// @nodoc
class __$StatsCopyWithImpl<$Res> extends _$StatsCopyWithImpl<$Res>
    implements _$StatsCopyWith<$Res> {
  __$StatsCopyWithImpl(_Stats _value, $Res Function(_Stats) _then)
      : super(_value, (v) => _then(v as _Stats));

  @override
  _Stats get _value => super._value as _Stats;

  @override
  $Res call({
    Object volume = freezed,
    Object price = freezed,
    Object timestamp = freezed,
    Object date = freezed,
  }) {
    return _then(_Stats(
      volume: volume == freezed ? _value.volume : volume as String,
      price: price == freezed ? _value.price : price as String,
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      date: date == freezed ? _value.date : date as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Stats implements _Stats {
  _$_Stats({this.volume, this.price, this.timestamp, this.date});

  factory _$_Stats.fromJson(Map<String, dynamic> json) =>
      _$_$_StatsFromJson(json);

  @override
  final String volume;
  @override
  final String price;
  @override
  final int timestamp;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'Stats(volume: $volume, price: $price, timestamp: $timestamp, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Stats &&
            (identical(other.volume, volume) ||
                const DeepCollectionEquality().equals(other.volume, volume)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(volume) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(date);

  @JsonKey(ignore: true)
  @override
  _$StatsCopyWith<_Stats> get copyWith =>
      __$StatsCopyWithImpl<_Stats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_StatsToJson(this);
  }
}

abstract class _Stats implements Stats {
  factory _Stats({String volume, String price, int timestamp, DateTime date}) =
      _$_Stats;

  factory _Stats.fromJson(Map<String, dynamic> json) = _$_Stats.fromJson;

  @override
  String get volume;
  @override
  String get price;
  @override
  int get timestamp;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$StatsCopyWith<_Stats> get copyWith;
}

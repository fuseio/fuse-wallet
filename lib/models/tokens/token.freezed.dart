// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
mixin _$Token {
  String get address => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  BigInt get amount => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  bool get isNative => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int? get timestamp => throw _privateConstructorUsedError;
  Price? get priceInfo => throw _privateConstructorUsedError;
  String? get communityAddress => throw _privateConstructorUsedError;
  TimeFrame get timeFrame => throw _privateConstructorUsedError;
  num get priceChange => throw _privateConstructorUsedError;
  List<IntervalStats> get intervalStats => throw _privateConstructorUsedError;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res>;
  $Res call(
      {String address,
      String name,
      String symbol,
      BigInt amount,
      int decimals,
      bool isNative,
      String? imageUrl,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      TimeFrame timeFrame,
      num priceChange,
      List<IntervalStats> intervalStats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions});

  $PriceCopyWith<$Res>? get priceInfo;
  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class _$TokenCopyWithImpl<$Res> implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  final Token _value;
  // ignore: unused_field
  final $Res Function(Token) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? amount = freezed,
    Object? decimals = freezed,
    Object? isNative = freezed,
    Object? imageUrl = freezed,
    Object? timestamp = freezed,
    Object? priceInfo = freezed,
    Object? communityAddress = freezed,
    Object? timeFrame = freezed,
    Object? priceChange = freezed,
    Object? intervalStats = freezed,
    Object? walletActions = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      isNative: isNative == freezed
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      priceInfo: priceInfo == freezed
          ? _value.priceInfo
          : priceInfo // ignore: cast_nullable_to_non_nullable
              as Price?,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      timeFrame: timeFrame == freezed
          ? _value.timeFrame
          : timeFrame // ignore: cast_nullable_to_non_nullable
              as TimeFrame,
      priceChange: priceChange == freezed
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as num,
      intervalStats: intervalStats == freezed
          ? _value.intervalStats
          : intervalStats // ignore: cast_nullable_to_non_nullable
              as List<IntervalStats>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
    ));
  }

  @override
  $PriceCopyWith<$Res>? get priceInfo {
    if (_value.priceInfo == null) {
      return null;
    }

    return $PriceCopyWith<$Res>(_value.priceInfo!, (value) {
      return _then(_value.copyWith(priceInfo: value));
    });
  }

  @override
  $WalletActionsCopyWith<$Res>? get walletActions {
    if (_value.walletActions == null) {
      return null;
    }

    return $WalletActionsCopyWith<$Res>(_value.walletActions!, (value) {
      return _then(_value.copyWith(walletActions: value));
    });
  }
}

/// @nodoc
abstract class _$$_TokenCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$_TokenCopyWith(_$_Token value, $Res Function(_$_Token) then) =
      __$$_TokenCopyWithImpl<$Res>;
  @override
  $Res call(
      {String address,
      String name,
      String symbol,
      BigInt amount,
      int decimals,
      bool isNative,
      String? imageUrl,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      TimeFrame timeFrame,
      num priceChange,
      List<IntervalStats> intervalStats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions});

  @override
  $PriceCopyWith<$Res>? get priceInfo;
  @override
  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class __$$_TokenCopyWithImpl<$Res> extends _$TokenCopyWithImpl<$Res>
    implements _$$_TokenCopyWith<$Res> {
  __$$_TokenCopyWithImpl(_$_Token _value, $Res Function(_$_Token) _then)
      : super(_value, (v) => _then(v as _$_Token));

  @override
  _$_Token get _value => super._value as _$_Token;

  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? amount = freezed,
    Object? decimals = freezed,
    Object? isNative = freezed,
    Object? imageUrl = freezed,
    Object? timestamp = freezed,
    Object? priceInfo = freezed,
    Object? communityAddress = freezed,
    Object? timeFrame = freezed,
    Object? priceChange = freezed,
    Object? intervalStats = freezed,
    Object? walletActions = freezed,
  }) {
    return _then(_$_Token(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      isNative: isNative == freezed
          ? _value.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      priceInfo: priceInfo == freezed
          ? _value.priceInfo
          : priceInfo // ignore: cast_nullable_to_non_nullable
              as Price?,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      timeFrame: timeFrame == freezed
          ? _value.timeFrame
          : timeFrame // ignore: cast_nullable_to_non_nullable
              as TimeFrame,
      priceChange: priceChange == freezed
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as num,
      intervalStats: intervalStats == freezed
          ? _value.intervalStats
          : intervalStats // ignore: cast_nullable_to_non_nullable
              as List<IntervalStats>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Token extends _Token with DiagnosticableTreeMixin {
  _$_Token(
      {required this.address,
      required this.name,
      required this.symbol,
      required this.amount,
      required this.decimals,
      this.isNative = false,
      this.imageUrl,
      this.timestamp,
      this.priceInfo,
      this.communityAddress,
      this.timeFrame = TimeFrame.day,
      this.priceChange = 0,
      this.intervalStats = const [],
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions})
      : super._();

  factory _$_Token.fromJson(Map<String, dynamic> json) =>
      _$$_TokenFromJson(json);

  @override
  final String address;
  @override
  final String name;
  @override
  final String symbol;
  @override
  final BigInt amount;
  @override
  final int decimals;
  @override
  @JsonKey()
  final bool isNative;
  @override
  final String? imageUrl;
  @override
  final int? timestamp;
  @override
  final Price? priceInfo;
  @override
  final String? communityAddress;
  @override
  @JsonKey()
  final TimeFrame timeFrame;
  @override
  @JsonKey()
  final num priceChange;
  @override
  @JsonKey()
  final List<IntervalStats> intervalStats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions? walletActions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Token(address: $address, name: $name, symbol: $symbol, amount: $amount, decimals: $decimals, isNative: $isNative, imageUrl: $imageUrl, timestamp: $timestamp, priceInfo: $priceInfo, communityAddress: $communityAddress, timeFrame: $timeFrame, priceChange: $priceChange, intervalStats: $intervalStats, walletActions: $walletActions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Token'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('symbol', symbol))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('decimals', decimals))
      ..add(DiagnosticsProperty('isNative', isNative))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('priceInfo', priceInfo))
      ..add(DiagnosticsProperty('communityAddress', communityAddress))
      ..add(DiagnosticsProperty('timeFrame', timeFrame))
      ..add(DiagnosticsProperty('priceChange', priceChange))
      ..add(DiagnosticsProperty('intervalStats', intervalStats))
      ..add(DiagnosticsProperty('walletActions', walletActions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Token &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.symbol, symbol) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.decimals, decimals) &&
            const DeepCollectionEquality().equals(other.isNative, isNative) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.priceInfo, priceInfo) &&
            const DeepCollectionEquality()
                .equals(other.communityAddress, communityAddress) &&
            const DeepCollectionEquality().equals(other.timeFrame, timeFrame) &&
            const DeepCollectionEquality()
                .equals(other.priceChange, priceChange) &&
            const DeepCollectionEquality()
                .equals(other.intervalStats, intervalStats) &&
            const DeepCollectionEquality()
                .equals(other.walletActions, walletActions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(symbol),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(decimals),
      const DeepCollectionEquality().hash(isNative),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(priceInfo),
      const DeepCollectionEquality().hash(communityAddress),
      const DeepCollectionEquality().hash(timeFrame),
      const DeepCollectionEquality().hash(priceChange),
      const DeepCollectionEquality().hash(intervalStats),
      const DeepCollectionEquality().hash(walletActions));

  @JsonKey(ignore: true)
  @override
  _$$_TokenCopyWith<_$_Token> get copyWith =>
      __$$_TokenCopyWithImpl<_$_Token>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenToJson(
      this,
    );
  }
}

abstract class _Token extends Token {
  factory _Token(
      {required final String address,
      required final String name,
      required final String symbol,
      required final BigInt amount,
      required final int decimals,
      final bool isNative,
      final String? imageUrl,
      final int? timestamp,
      final Price? priceInfo,
      final String? communityAddress,
      final TimeFrame timeFrame,
      final num priceChange,
      final List<IntervalStats> intervalStats,
      @JsonKey(fromJson: walletActionsFromJson)
          final WalletActions? walletActions}) = _$_Token;
  _Token._() : super._();

  factory _Token.fromJson(Map<String, dynamic> json) = _$_Token.fromJson;

  @override
  String get address;
  @override
  String get name;
  @override
  String get symbol;
  @override
  BigInt get amount;
  @override
  int get decimals;
  @override
  bool get isNative;
  @override
  String? get imageUrl;
  @override
  int? get timestamp;
  @override
  Price? get priceInfo;
  @override
  String? get communityAddress;
  @override
  TimeFrame get timeFrame;
  @override
  num get priceChange;
  @override
  List<IntervalStats> get intervalStats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions;
  @override
  @JsonKey(ignore: true)
  _$$_TokenCopyWith<_$_Token> get copyWith =>
      throw _privateConstructorUsedError;
}

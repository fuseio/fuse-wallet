// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
class _$TokenTearOff {
  const _$TokenTearOff();

  _Token call(
      {required String address,
      required String name,
      required String symbol,
      required BigInt amount,
      required int decimals,
      bool isNative = false,
      String? imageUrl,
      @JsonKey(ignore: true) String? subtitle,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      String? originNetwork,
      num priceChange = 0,
      @JsonKey(ignore: true) num priceDiff = 0,
      @JsonKey(ignore: true) int priceDiffLimitInDays = 0,
      @JsonKey(ignore: true) List<Stats> stats = const [],
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions}) {
    return _Token(
      address: address,
      name: name,
      symbol: symbol,
      amount: amount,
      decimals: decimals,
      isNative: isNative,
      imageUrl: imageUrl,
      subtitle: subtitle,
      timestamp: timestamp,
      priceInfo: priceInfo,
      communityAddress: communityAddress,
      originNetwork: originNetwork,
      priceChange: priceChange,
      priceDiff: priceDiff,
      priceDiffLimitInDays: priceDiffLimitInDays,
      stats: stats,
      walletActions: walletActions,
    );
  }

  Token fromJson(Map<String, Object?> json) {
    return Token.fromJson(json);
  }
}

/// @nodoc
const $Token = _$TokenTearOff();

/// @nodoc
mixin _$Token {
  String get address => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  BigInt get amount => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  bool get isNative => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get subtitle => throw _privateConstructorUsedError;
  int? get timestamp => throw _privateConstructorUsedError;
  Price? get priceInfo => throw _privateConstructorUsedError;
  String? get communityAddress => throw _privateConstructorUsedError;
  String? get originNetwork => throw _privateConstructorUsedError;
  num get priceChange => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  num get priceDiff => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  int get priceDiffLimitInDays => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  List<Stats> get stats => throw _privateConstructorUsedError;
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
      @JsonKey(ignore: true) String? subtitle,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      String? originNetwork,
      num priceChange,
      @JsonKey(ignore: true) num priceDiff,
      @JsonKey(ignore: true) int priceDiffLimitInDays,
      @JsonKey(ignore: true) List<Stats> stats,
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
    Object? subtitle = freezed,
    Object? timestamp = freezed,
    Object? priceInfo = freezed,
    Object? communityAddress = freezed,
    Object? originNetwork = freezed,
    Object? priceChange = freezed,
    Object? priceDiff = freezed,
    Object? priceDiffLimitInDays = freezed,
    Object? stats = freezed,
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
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
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
      originNetwork: originNetwork == freezed
          ? _value.originNetwork
          : originNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
      priceChange: priceChange == freezed
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as num,
      priceDiff: priceDiff == freezed
          ? _value.priceDiff
          : priceDiff // ignore: cast_nullable_to_non_nullable
              as num,
      priceDiffLimitInDays: priceDiffLimitInDays == freezed
          ? _value.priceDiffLimitInDays
          : priceDiffLimitInDays // ignore: cast_nullable_to_non_nullable
              as int,
      stats: stats == freezed
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
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
abstract class _$TokenCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$TokenCopyWith(_Token value, $Res Function(_Token) then) =
      __$TokenCopyWithImpl<$Res>;
  @override
  $Res call(
      {String address,
      String name,
      String symbol,
      BigInt amount,
      int decimals,
      bool isNative,
      String? imageUrl,
      @JsonKey(ignore: true) String? subtitle,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      String? originNetwork,
      num priceChange,
      @JsonKey(ignore: true) num priceDiff,
      @JsonKey(ignore: true) int priceDiffLimitInDays,
      @JsonKey(ignore: true) List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions});

  @override
  $PriceCopyWith<$Res>? get priceInfo;
  @override
  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class __$TokenCopyWithImpl<$Res> extends _$TokenCopyWithImpl<$Res>
    implements _$TokenCopyWith<$Res> {
  __$TokenCopyWithImpl(_Token _value, $Res Function(_Token) _then)
      : super(_value, (v) => _then(v as _Token));

  @override
  _Token get _value => super._value as _Token;

  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? amount = freezed,
    Object? decimals = freezed,
    Object? isNative = freezed,
    Object? imageUrl = freezed,
    Object? subtitle = freezed,
    Object? timestamp = freezed,
    Object? priceInfo = freezed,
    Object? communityAddress = freezed,
    Object? originNetwork = freezed,
    Object? priceChange = freezed,
    Object? priceDiff = freezed,
    Object? priceDiffLimitInDays = freezed,
    Object? stats = freezed,
    Object? walletActions = freezed,
  }) {
    return _then(_Token(
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
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
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
      originNetwork: originNetwork == freezed
          ? _value.originNetwork
          : originNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
      priceChange: priceChange == freezed
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as num,
      priceDiff: priceDiff == freezed
          ? _value.priceDiff
          : priceDiff // ignore: cast_nullable_to_non_nullable
              as num,
      priceDiffLimitInDays: priceDiffLimitInDays == freezed
          ? _value.priceDiffLimitInDays
          : priceDiffLimitInDays // ignore: cast_nullable_to_non_nullable
              as int,
      stats: stats == freezed
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
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
      @JsonKey(ignore: true) this.subtitle,
      this.timestamp,
      this.priceInfo,
      this.communityAddress,
      this.originNetwork,
      this.priceChange = 0,
      @JsonKey(ignore: true) this.priceDiff = 0,
      @JsonKey(ignore: true) this.priceDiffLimitInDays = 0,
      @JsonKey(ignore: true) this.stats = const [],
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
  @JsonKey(defaultValue: false)
  @override
  final bool isNative;
  @override
  final String? imageUrl;
  @override
  @JsonKey(ignore: true)
  final String? subtitle;
  @override
  final int? timestamp;
  @override
  final Price? priceInfo;
  @override
  final String? communityAddress;
  @override
  final String? originNetwork;
  @JsonKey(defaultValue: 0)
  @override
  final num priceChange;
  @override
  @JsonKey(ignore: true)
  final num priceDiff;
  @override
  @JsonKey(ignore: true)
  final int priceDiffLimitInDays;
  @override
  @JsonKey(ignore: true)
  final List<Stats> stats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions? walletActions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Token(address: $address, name: $name, symbol: $symbol, amount: $amount, decimals: $decimals, isNative: $isNative, imageUrl: $imageUrl, subtitle: $subtitle, timestamp: $timestamp, priceInfo: $priceInfo, communityAddress: $communityAddress, originNetwork: $originNetwork, priceChange: $priceChange, priceDiff: $priceDiff, priceDiffLimitInDays: $priceDiffLimitInDays, stats: $stats, walletActions: $walletActions)';
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
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('priceInfo', priceInfo))
      ..add(DiagnosticsProperty('communityAddress', communityAddress))
      ..add(DiagnosticsProperty('originNetwork', originNetwork))
      ..add(DiagnosticsProperty('priceChange', priceChange))
      ..add(DiagnosticsProperty('priceDiff', priceDiff))
      ..add(DiagnosticsProperty('priceDiffLimitInDays', priceDiffLimitInDays))
      ..add(DiagnosticsProperty('stats', stats))
      ..add(DiagnosticsProperty('walletActions', walletActions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Token &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.isNative, isNative) ||
                other.isNative == isNative) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.priceInfo, priceInfo) ||
                other.priceInfo == priceInfo) &&
            (identical(other.communityAddress, communityAddress) ||
                other.communityAddress == communityAddress) &&
            (identical(other.originNetwork, originNetwork) ||
                other.originNetwork == originNetwork) &&
            (identical(other.priceChange, priceChange) ||
                other.priceChange == priceChange) &&
            (identical(other.priceDiff, priceDiff) ||
                other.priceDiff == priceDiff) &&
            (identical(other.priceDiffLimitInDays, priceDiffLimitInDays) ||
                other.priceDiffLimitInDays == priceDiffLimitInDays) &&
            const DeepCollectionEquality().equals(other.stats, stats) &&
            (identical(other.walletActions, walletActions) ||
                other.walletActions == walletActions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      name,
      symbol,
      amount,
      decimals,
      isNative,
      imageUrl,
      subtitle,
      timestamp,
      priceInfo,
      communityAddress,
      originNetwork,
      priceChange,
      priceDiff,
      priceDiffLimitInDays,
      const DeepCollectionEquality().hash(stats),
      walletActions);

  @JsonKey(ignore: true)
  @override
  _$TokenCopyWith<_Token> get copyWith =>
      __$TokenCopyWithImpl<_Token>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenToJson(this);
  }
}

abstract class _Token extends Token {
  factory _Token(
      {required String address,
      required String name,
      required String symbol,
      required BigInt amount,
      required int decimals,
      bool isNative,
      String? imageUrl,
      @JsonKey(ignore: true)
          String? subtitle,
      int? timestamp,
      Price? priceInfo,
      String? communityAddress,
      String? originNetwork,
      num priceChange,
      @JsonKey(ignore: true)
          num priceDiff,
      @JsonKey(ignore: true)
          int priceDiffLimitInDays,
      @JsonKey(ignore: true)
          List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions? walletActions}) = _$_Token;
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
  @JsonKey(ignore: true)
  String? get subtitle;
  @override
  int? get timestamp;
  @override
  Price? get priceInfo;
  @override
  String? get communityAddress;
  @override
  String? get originNetwork;
  @override
  num get priceChange;
  @override
  @JsonKey(ignore: true)
  num get priceDiff;
  @override
  @JsonKey(ignore: true)
  int get priceDiffLimitInDays;
  @override
  @JsonKey(ignore: true)
  List<Stats> get stats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions;
  @override
  @JsonKey(ignore: true)
  _$TokenCopyWith<_Token> get copyWith => throw _privateConstructorUsedError;
}

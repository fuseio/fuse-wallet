// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
class _$TokenTearOff {
  const _$TokenTearOff();

// ignore: unused_element
  _Token call(
      {String address,
      String name,
      bool isNative = false,
      String symbol,
      String imageUrl,
      int decimals,
      BigInt amount,
      @JsonKey(ignore: true) String subtitle,
      int timestamp,
      Price priceInfo,
      String communityAddress,
      String originNetwork,
      num priceChange,
      List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions walletActions}) {
    return _Token(
      address: address,
      name: name,
      isNative: isNative,
      symbol: symbol,
      imageUrl: imageUrl,
      decimals: decimals,
      amount: amount,
      subtitle: subtitle,
      timestamp: timestamp,
      priceInfo: priceInfo,
      communityAddress: communityAddress,
      originNetwork: originNetwork,
      priceChange: priceChange,
      stats: stats,
      walletActions: walletActions,
    );
  }

// ignore: unused_element
  Token fromJson(Map<String, Object> json) {
    return Token.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Token = _$TokenTearOff();

/// @nodoc
mixin _$Token {
  String get address;
  String get name;
  bool get isNative;
  String get symbol;
  String get imageUrl;
  int get decimals;
  BigInt get amount;
  @JsonKey(ignore: true)
  String get subtitle;
  int get timestamp;
  Price get priceInfo;
  String get communityAddress;
  String get originNetwork;
  num get priceChange;
  List<Stats> get stats;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions get walletActions;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res>;
  $Res call(
      {String address,
      String name,
      bool isNative,
      String symbol,
      String imageUrl,
      int decimals,
      BigInt amount,
      @JsonKey(ignore: true) String subtitle,
      int timestamp,
      Price priceInfo,
      String communityAddress,
      String originNetwork,
      num priceChange,
      List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions walletActions});

  $PriceCopyWith<$Res> get priceInfo;
  $WalletActionsCopyWith<$Res> get walletActions;
}

/// @nodoc
class _$TokenCopyWithImpl<$Res> implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  final Token _value;
  // ignore: unused_field
  final $Res Function(Token) _then;

  @override
  $Res call({
    Object address = freezed,
    Object name = freezed,
    Object isNative = freezed,
    Object symbol = freezed,
    Object imageUrl = freezed,
    Object decimals = freezed,
    Object amount = freezed,
    Object subtitle = freezed,
    Object timestamp = freezed,
    Object priceInfo = freezed,
    Object communityAddress = freezed,
    Object originNetwork = freezed,
    Object priceChange = freezed,
    Object stats = freezed,
    Object walletActions = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed ? _value.address : address as String,
      name: name == freezed ? _value.name : name as String,
      isNative: isNative == freezed ? _value.isNative : isNative as bool,
      symbol: symbol == freezed ? _value.symbol : symbol as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      decimals: decimals == freezed ? _value.decimals : decimals as int,
      amount: amount == freezed ? _value.amount : amount as BigInt,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      priceInfo: priceInfo == freezed ? _value.priceInfo : priceInfo as Price,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress as String,
      originNetwork: originNetwork == freezed
          ? _value.originNetwork
          : originNetwork as String,
      priceChange:
          priceChange == freezed ? _value.priceChange : priceChange as num,
      stats: stats == freezed ? _value.stats : stats as List<Stats>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions as WalletActions,
    ));
  }

  @override
  $PriceCopyWith<$Res> get priceInfo {
    if (_value.priceInfo == null) {
      return null;
    }
    return $PriceCopyWith<$Res>(_value.priceInfo, (value) {
      return _then(_value.copyWith(priceInfo: value));
    });
  }

  @override
  $WalletActionsCopyWith<$Res> get walletActions {
    if (_value.walletActions == null) {
      return null;
    }
    return $WalletActionsCopyWith<$Res>(_value.walletActions, (value) {
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
      bool isNative,
      String symbol,
      String imageUrl,
      int decimals,
      BigInt amount,
      @JsonKey(ignore: true) String subtitle,
      int timestamp,
      Price priceInfo,
      String communityAddress,
      String originNetwork,
      num priceChange,
      List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions walletActions});

  @override
  $PriceCopyWith<$Res> get priceInfo;
  @override
  $WalletActionsCopyWith<$Res> get walletActions;
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
    Object address = freezed,
    Object name = freezed,
    Object isNative = freezed,
    Object symbol = freezed,
    Object imageUrl = freezed,
    Object decimals = freezed,
    Object amount = freezed,
    Object subtitle = freezed,
    Object timestamp = freezed,
    Object priceInfo = freezed,
    Object communityAddress = freezed,
    Object originNetwork = freezed,
    Object priceChange = freezed,
    Object stats = freezed,
    Object walletActions = freezed,
  }) {
    return _then(_Token(
      address: address == freezed ? _value.address : address as String,
      name: name == freezed ? _value.name : name as String,
      isNative: isNative == freezed ? _value.isNative : isNative as bool,
      symbol: symbol == freezed ? _value.symbol : symbol as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      decimals: decimals == freezed ? _value.decimals : decimals as int,
      amount: amount == freezed ? _value.amount : amount as BigInt,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      priceInfo: priceInfo == freezed ? _value.priceInfo : priceInfo as Price,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress as String,
      originNetwork: originNetwork == freezed
          ? _value.originNetwork
          : originNetwork as String,
      priceChange:
          priceChange == freezed ? _value.priceChange : priceChange as num,
      stats: stats == freezed ? _value.stats : stats as List<Stats>,
      walletActions: walletActions == freezed
          ? _value.walletActions
          : walletActions as WalletActions,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Token extends _Token {
  _$_Token(
      {this.address,
      this.name,
      this.isNative = false,
      this.symbol,
      this.imageUrl,
      this.decimals,
      this.amount,
      @JsonKey(ignore: true) this.subtitle,
      this.timestamp,
      this.priceInfo,
      this.communityAddress,
      this.originNetwork,
      this.priceChange,
      this.stats,
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions})
      : assert(isNative != null),
        super._();

  factory _$_Token.fromJson(Map<String, dynamic> json) =>
      _$_$_TokenFromJson(json);

  @override
  final String address;
  @override
  final String name;
  @JsonKey(defaultValue: false)
  @override
  final bool isNative;
  @override
  final String symbol;
  @override
  final String imageUrl;
  @override
  final int decimals;
  @override
  final BigInt amount;
  @override
  @JsonKey(ignore: true)
  final String subtitle;
  @override
  final int timestamp;
  @override
  final Price priceInfo;
  @override
  final String communityAddress;
  @override
  final String originNetwork;
  @override
  final num priceChange;
  @override
  final List<Stats> stats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions walletActions;

  @override
  String toString() {
    return 'Token(address: $address, name: $name, isNative: $isNative, symbol: $symbol, imageUrl: $imageUrl, decimals: $decimals, amount: $amount, subtitle: $subtitle, timestamp: $timestamp, priceInfo: $priceInfo, communityAddress: $communityAddress, originNetwork: $originNetwork, priceChange: $priceChange, stats: $stats, walletActions: $walletActions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Token &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isNative, isNative) ||
                const DeepCollectionEquality()
                    .equals(other.isNative, isNative)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.decimals, decimals) ||
                const DeepCollectionEquality()
                    .equals(other.decimals, decimals)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.priceInfo, priceInfo) ||
                const DeepCollectionEquality()
                    .equals(other.priceInfo, priceInfo)) &&
            (identical(other.communityAddress, communityAddress) ||
                const DeepCollectionEquality()
                    .equals(other.communityAddress, communityAddress)) &&
            (identical(other.originNetwork, originNetwork) ||
                const DeepCollectionEquality()
                    .equals(other.originNetwork, originNetwork)) &&
            (identical(other.priceChange, priceChange) ||
                const DeepCollectionEquality()
                    .equals(other.priceChange, priceChange)) &&
            (identical(other.stats, stats) ||
                const DeepCollectionEquality().equals(other.stats, stats)) &&
            (identical(other.walletActions, walletActions) ||
                const DeepCollectionEquality()
                    .equals(other.walletActions, walletActions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(isNative) ^
      const DeepCollectionEquality().hash(symbol) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(decimals) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(priceInfo) ^
      const DeepCollectionEquality().hash(communityAddress) ^
      const DeepCollectionEquality().hash(originNetwork) ^
      const DeepCollectionEquality().hash(priceChange) ^
      const DeepCollectionEquality().hash(stats) ^
      const DeepCollectionEquality().hash(walletActions);

  @JsonKey(ignore: true)
  @override
  _$TokenCopyWith<_Token> get copyWith =>
      __$TokenCopyWithImpl<_Token>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TokenToJson(this);
  }
}

abstract class _Token extends Token {
  _Token._() : super._();
  factory _Token(
      {String address,
      String name,
      bool isNative,
      String symbol,
      String imageUrl,
      int decimals,
      BigInt amount,
      @JsonKey(ignore: true)
          String subtitle,
      int timestamp,
      Price priceInfo,
      String communityAddress,
      String originNetwork,
      num priceChange,
      List<Stats> stats,
      @JsonKey(fromJson: walletActionsFromJson)
          WalletActions walletActions}) = _$_Token;

  factory _Token.fromJson(Map<String, dynamic> json) = _$_Token.fromJson;

  @override
  String get address;
  @override
  String get name;
  @override
  bool get isNative;
  @override
  String get symbol;
  @override
  String get imageUrl;
  @override
  int get decimals;
  @override
  BigInt get amount;
  @override
  @JsonKey(ignore: true)
  String get subtitle;
  @override
  int get timestamp;
  @override
  Price get priceInfo;
  @override
  String get communityAddress;
  @override
  String get originNetwork;
  @override
  num get priceChange;
  @override
  List<Stats> get stats;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions get walletActions;
  @override
  @JsonKey(ignore: true)
  _$TokenCopyWith<_Token> get copyWith;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'wallet_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletAction _$WalletActionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'createWallet':
      return CreateWallet.fromJson(json);
    case 'fiatDeposit':
      return FiatDeposit.fromJson(json);
    case 'joinCommunity':
      return JoinCommunity.fromJson(json);
    case 'bonus':
      return Bonus.fromJson(json);
    case 'send':
      return Send.fromJson(json);
    case 'receive':
      return Receive.fromJson(json);
    case 'swap':
      return Swap.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$WalletActionTearOff {
  const _$WalletActionTearOff();

  CreateWallet createWallet(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'createWallet',
      String? txHash = null,
      required String status,
      required int blockNumber}) {
    return CreateWallet(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
    );
  }

  FiatDeposit fiatDeposit(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'fiat-deposit',
      String? txHash = null,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) {
    return FiatDeposit(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tokenAddress: tokenAddress,
      from: from,
      to: to,
      value: value,
      tokenName: tokenName,
      tokenSymbol: tokenSymbol,
      tokenDecimal: tokenDecimal,
    );
  }

  JoinCommunity joinCommunity(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'joinCommunity',
      String? txHash = null,
      required String status,
      required int blockNumber,
      required String communityAddress,
      required String tokenAddress,
      String? communityName = null}) {
    return JoinCommunity(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      communityAddress: communityAddress,
      tokenAddress: tokenAddress,
      communityName: communityName,
    );
  }

  Bonus bonus(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'tokenBonus',
      String? txHash = null,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal,
      String? bonusType = null}) {
    return Bonus(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tokenAddress: tokenAddress,
      from: from,
      to: to,
      value: value,
      tokenName: tokenName,
      tokenSymbol: tokenSymbol,
      tokenDecimal: tokenDecimal,
      bonusType: bonusType,
    );
  }

  Send send(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'sendTokens',
      String? txHash = null,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) {
    return Send(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tokenAddress: tokenAddress,
      from: from,
      to: to,
      value: value,
      tokenName: tokenName,
      tokenSymbol: tokenSymbol,
      tokenDecimal: tokenDecimal,
    );
  }

  Receive receive(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name = 'receiveTokens',
      String? txHash = null,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) {
    return Receive(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tokenAddress: tokenAddress,
      from: from,
      to: to,
      value: value,
      tokenName: tokenName,
      tokenSymbol: tokenSymbol,
      tokenDecimal: tokenDecimal,
    );
  }

  Swap swap(
      {required int timestamp = null,
      @JsonKey(name: '_id') required String id,
      required String name = 'swapTokens',
      String? txHash = null,
      required String status,
      required int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo? tradeInfo = null}) {
    return Swap(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tradeInfo: tradeInfo,
    );
  }

  WalletAction fromJson(Map<String, Object> json) {
    return WalletAction.fromJson(json);
  }
}

/// @nodoc
const $WalletAction = _$WalletActionTearOff();

/// @nodoc
mixin _$WalletAction {
  int get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get txHash => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get blockNumber => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletActionCopyWith<WalletAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletActionCopyWith<$Res> {
  factory $WalletActionCopyWith(
          WalletAction value, $Res Function(WalletAction) then) =
      _$WalletActionCopyWithImpl<$Res>;
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber});
}

/// @nodoc
class _$WalletActionCopyWithImpl<$Res> implements $WalletActionCopyWith<$Res> {
  _$WalletActionCopyWithImpl(this._value, this._then);

  final WalletAction _value;
  // ignore: unused_field
  final $Res Function(WalletAction) _then;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class $CreateWalletCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory $CreateWalletCopyWith(
          CreateWallet value, $Res Function(CreateWallet) then) =
      _$CreateWalletCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber});
}

/// @nodoc
class _$CreateWalletCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $CreateWalletCopyWith<$Res> {
  _$CreateWalletCopyWithImpl(
      CreateWallet _value, $Res Function(CreateWallet) _then)
      : super(_value, (v) => _then(v as CreateWallet));

  @override
  CreateWallet get _value => super._value as CreateWallet;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(CreateWallet(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$CreateWallet extends CreateWallet with DiagnosticableTreeMixin {
  const _$CreateWallet(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'createWallet',
      this.txHash = null,
      required this.status,
      required this.blockNumber})
      : super._();

  factory _$CreateWallet.fromJson(Map<String, dynamic> json) =>
      _$_$CreateWalletFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'createWallet')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.createWallet(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.createWallet'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateWallet &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber);

  @JsonKey(ignore: true)
  @override
  $CreateWalletCopyWith<CreateWallet> get copyWith =>
      _$CreateWalletCopyWithImpl<CreateWallet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return createWallet(timestamp, id, name, txHash, status, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (createWallet != null) {
      return createWallet(timestamp, id, name, txHash, status, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return createWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (createWallet != null) {
      return createWallet(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$CreateWalletToJson(this)..['runtimeType'] = 'createWallet';
  }
}

abstract class CreateWallet extends WalletAction {
  const factory CreateWallet(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber}) = _$CreateWallet;
  const CreateWallet._() : super._();

  factory CreateWallet.fromJson(Map<String, dynamic> json) =
      _$CreateWallet.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $CreateWalletCopyWith<CreateWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiatDepositCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory $FiatDepositCopyWith(
          FiatDeposit value, $Res Function(FiatDeposit) then) =
      _$FiatDepositCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class _$FiatDepositCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $FiatDepositCopyWith<$Res> {
  _$FiatDepositCopyWithImpl(
      FiatDeposit _value, $Res Function(FiatDeposit) _then)
      : super(_value, (v) => _then(v as FiatDeposit));

  @override
  FiatDeposit get _value => super._value as FiatDeposit;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? tokenAddress = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? value = freezed,
    Object? tokenName = freezed,
    Object? tokenSymbol = freezed,
    Object? tokenDecimal = freezed,
  }) {
    return _then(FiatDeposit(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: tokenName == freezed
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: tokenDecimal == freezed
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$FiatDeposit extends FiatDeposit with DiagnosticableTreeMixin {
  const _$FiatDeposit(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'fiat-deposit',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal})
      : super._();

  factory _$FiatDeposit.fromJson(Map<String, dynamic> json) =>
      _$_$FiatDepositFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'fiat-deposit')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.fiatDeposit(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.fiatDeposit'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FiatDeposit &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.tokenName, tokenName) ||
                const DeepCollectionEquality()
                    .equals(other.tokenName, tokenName)) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSymbol, tokenSymbol)) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                const DeepCollectionEquality()
                    .equals(other.tokenDecimal, tokenDecimal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(tokenName) ^
      const DeepCollectionEquality().hash(tokenSymbol) ^
      const DeepCollectionEquality().hash(tokenDecimal);

  @JsonKey(ignore: true)
  @override
  $FiatDepositCopyWith<FiatDeposit> get copyWith =>
      _$FiatDepositCopyWithImpl<FiatDeposit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return fiatDeposit(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (fiatDeposit != null) {
      return fiatDeposit(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return fiatDeposit(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (fiatDeposit != null) {
      return fiatDeposit(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$FiatDepositToJson(this)..['runtimeType'] = 'fiatDeposit';
  }
}

abstract class FiatDeposit extends WalletAction {
  const factory FiatDeposit(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) = _$FiatDeposit;
  const FiatDeposit._() : super._();

  factory FiatDeposit.fromJson(Map<String, dynamic> json) =
      _$FiatDeposit.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  BigInt get value => throw _privateConstructorUsedError;
  String get tokenName => throw _privateConstructorUsedError;
  String get tokenSymbol => throw _privateConstructorUsedError;
  int get tokenDecimal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FiatDepositCopyWith<FiatDeposit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinCommunityCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory $JoinCommunityCopyWith(
          JoinCommunity value, $Res Function(JoinCommunity) then) =
      _$JoinCommunityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress,
      String? communityName});
}

/// @nodoc
class _$JoinCommunityCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $JoinCommunityCopyWith<$Res> {
  _$JoinCommunityCopyWithImpl(
      JoinCommunity _value, $Res Function(JoinCommunity) _then)
      : super(_value, (v) => _then(v as JoinCommunity));

  @override
  JoinCommunity get _value => super._value as JoinCommunity;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? communityAddress = freezed,
    Object? tokenAddress = freezed,
    Object? communityName = freezed,
  }) {
    return _then(JoinCommunity(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      communityName: communityName == freezed
          ? _value.communityName
          : communityName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$JoinCommunity extends JoinCommunity with DiagnosticableTreeMixin {
  const _$JoinCommunity(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'joinCommunity',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      required this.communityAddress,
      required this.tokenAddress,
      this.communityName = null})
      : super._();

  factory _$JoinCommunity.fromJson(Map<String, dynamic> json) =>
      _$_$JoinCommunityFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'joinCommunity')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String communityAddress;
  @override
  final String tokenAddress;
  @JsonKey(defaultValue: null)
  @override
  final String? communityName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.joinCommunity(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, communityAddress: $communityAddress, tokenAddress: $tokenAddress, communityName: $communityName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.joinCommunity'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('communityAddress', communityAddress))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('communityName', communityName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JoinCommunity &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.communityAddress, communityAddress) ||
                const DeepCollectionEquality()
                    .equals(other.communityAddress, communityAddress)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.communityName, communityName) ||
                const DeepCollectionEquality()
                    .equals(other.communityName, communityName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(communityAddress) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(communityName);

  @JsonKey(ignore: true)
  @override
  $JoinCommunityCopyWith<JoinCommunity> get copyWith =>
      _$JoinCommunityCopyWithImpl<JoinCommunity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return joinCommunity(timestamp, id, name, txHash, status, blockNumber,
        communityAddress, tokenAddress, communityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (joinCommunity != null) {
      return joinCommunity(timestamp, id, name, txHash, status, blockNumber,
          communityAddress, tokenAddress, communityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return joinCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (joinCommunity != null) {
      return joinCommunity(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$JoinCommunityToJson(this)..['runtimeType'] = 'joinCommunity';
  }
}

abstract class JoinCommunity extends WalletAction {
  const factory JoinCommunity(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      required String communityAddress,
      required String tokenAddress,
      String? communityName}) = _$JoinCommunity;
  const JoinCommunity._() : super._();

  factory JoinCommunity.fromJson(Map<String, dynamic> json) =
      _$JoinCommunity.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  String get communityAddress => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String? get communityName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $JoinCommunityCopyWith<JoinCommunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $BonusCopyWith(Bonus value, $Res Function(Bonus) then) =
      _$BonusCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      String? bonusType});
}

/// @nodoc
class _$BonusCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $BonusCopyWith<$Res> {
  _$BonusCopyWithImpl(Bonus _value, $Res Function(Bonus) _then)
      : super(_value, (v) => _then(v as Bonus));

  @override
  Bonus get _value => super._value as Bonus;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? tokenAddress = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? value = freezed,
    Object? tokenName = freezed,
    Object? tokenSymbol = freezed,
    Object? tokenDecimal = freezed,
    Object? bonusType = freezed,
  }) {
    return _then(Bonus(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: tokenName == freezed
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: tokenDecimal == freezed
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      bonusType: bonusType == freezed
          ? _value.bonusType
          : bonusType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$Bonus extends Bonus with DiagnosticableTreeMixin {
  const _$Bonus(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'tokenBonus',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.bonusType = null})
      : super._();

  factory _$Bonus.fromJson(Map<String, dynamic> json) =>
      _$_$BonusFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'tokenBonus')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @JsonKey(defaultValue: null)
  @override
  final String? bonusType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.bonus(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, bonusType: $bonusType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.bonus'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('bonusType', bonusType));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Bonus &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.tokenName, tokenName) ||
                const DeepCollectionEquality()
                    .equals(other.tokenName, tokenName)) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSymbol, tokenSymbol)) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                const DeepCollectionEquality()
                    .equals(other.tokenDecimal, tokenDecimal)) &&
            (identical(other.bonusType, bonusType) ||
                const DeepCollectionEquality()
                    .equals(other.bonusType, bonusType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(tokenName) ^
      const DeepCollectionEquality().hash(tokenSymbol) ^
      const DeepCollectionEquality().hash(tokenDecimal) ^
      const DeepCollectionEquality().hash(bonusType);

  @JsonKey(ignore: true)
  @override
  $BonusCopyWith<Bonus> get copyWith =>
      _$BonusCopyWithImpl<Bonus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return bonus(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal, bonusType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (bonus != null) {
      return bonus(
          timestamp,
          id,
          name,
          txHash,
          status,
          blockNumber,
          tokenAddress,
          from,
          to,
          value,
          tokenName,
          tokenSymbol,
          tokenDecimal,
          bonusType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return bonus(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (bonus != null) {
      return bonus(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$BonusToJson(this)..['runtimeType'] = 'bonus';
  }
}

abstract class Bonus extends WalletAction {
  const factory Bonus(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal,
      String? bonusType}) = _$Bonus;
  const Bonus._() : super._();

  factory Bonus.fromJson(Map<String, dynamic> json) = _$Bonus.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  BigInt get value => throw _privateConstructorUsedError;
  String get tokenName => throw _privateConstructorUsedError;
  String get tokenSymbol => throw _privateConstructorUsedError;
  int get tokenDecimal => throw _privateConstructorUsedError;
  String? get bonusType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $BonusCopyWith<Bonus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $SendCopyWith(Send value, $Res Function(Send) then) =
      _$SendCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class _$SendCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $SendCopyWith<$Res> {
  _$SendCopyWithImpl(Send _value, $Res Function(Send) _then)
      : super(_value, (v) => _then(v as Send));

  @override
  Send get _value => super._value as Send;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? tokenAddress = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? value = freezed,
    Object? tokenName = freezed,
    Object? tokenSymbol = freezed,
    Object? tokenDecimal = freezed,
  }) {
    return _then(Send(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: tokenName == freezed
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: tokenDecimal == freezed
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$Send extends Send with DiagnosticableTreeMixin {
  const _$Send(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'sendTokens',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal})
      : super._();

  factory _$Send.fromJson(Map<String, dynamic> json) => _$_$SendFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'sendTokens')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.send(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.send'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Send &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.tokenName, tokenName) ||
                const DeepCollectionEquality()
                    .equals(other.tokenName, tokenName)) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSymbol, tokenSymbol)) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                const DeepCollectionEquality()
                    .equals(other.tokenDecimal, tokenDecimal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(tokenName) ^
      const DeepCollectionEquality().hash(tokenSymbol) ^
      const DeepCollectionEquality().hash(tokenDecimal);

  @JsonKey(ignore: true)
  @override
  $SendCopyWith<Send> get copyWith =>
      _$SendCopyWithImpl<Send>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return send(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$SendToJson(this)..['runtimeType'] = 'send';
  }
}

abstract class Send extends WalletAction {
  const factory Send(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) = _$Send;
  const Send._() : super._();

  factory Send.fromJson(Map<String, dynamic> json) = _$Send.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  BigInt get value => throw _privateConstructorUsedError;
  String get tokenName => throw _privateConstructorUsedError;
  String get tokenSymbol => throw _privateConstructorUsedError;
  int get tokenDecimal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SendCopyWith<Send> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiveCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $ReceiveCopyWith(Receive value, $Res Function(Receive) then) =
      _$ReceiveCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class _$ReceiveCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $ReceiveCopyWith<$Res> {
  _$ReceiveCopyWithImpl(Receive _value, $Res Function(Receive) _then)
      : super(_value, (v) => _then(v as Receive));

  @override
  Receive get _value => super._value as Receive;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? tokenAddress = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? value = freezed,
    Object? tokenName = freezed,
    Object? tokenSymbol = freezed,
    Object? tokenDecimal = freezed,
  }) {
    return _then(Receive(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: tokenName == freezed
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: tokenDecimal == freezed
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$Receive extends Receive with DiagnosticableTreeMixin {
  const _$Receive(
      {required this.timestamp,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'receiveTokens',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal})
      : super._();

  factory _$Receive.fromJson(Map<String, dynamic> json) =>
      _$_$ReceiveFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'receiveTokens')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.receive(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.receive'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Receive &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.tokenName, tokenName) ||
                const DeepCollectionEquality()
                    .equals(other.tokenName, tokenName)) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSymbol, tokenSymbol)) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                const DeepCollectionEquality()
                    .equals(other.tokenDecimal, tokenDecimal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(tokenName) ^
      const DeepCollectionEquality().hash(tokenSymbol) ^
      const DeepCollectionEquality().hash(tokenDecimal);

  @JsonKey(ignore: true)
  @override
  $ReceiveCopyWith<Receive> get copyWith =>
      _$ReceiveCopyWithImpl<Receive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return receive(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (receive != null) {
      return receive(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return receive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (receive != null) {
      return receive(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ReceiveToJson(this)..['runtimeType'] = 'receive';
  }
}

abstract class Receive extends WalletAction {
  const factory Receive(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      required String tokenAddress,
      required String from,
      required String to,
      required BigInt value,
      required String tokenName,
      required String tokenSymbol,
      required int tokenDecimal}) = _$Receive;
  const Receive._() : super._();

  factory Receive.fromJson(Map<String, dynamic> json) = _$Receive.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  BigInt get value => throw _privateConstructorUsedError;
  String get tokenName => throw _privateConstructorUsedError;
  String get tokenSymbol => throw _privateConstructorUsedError;
  int get tokenDecimal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ReceiveCopyWith<Receive> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $SwapCopyWith(Swap value, $Res Function(Swap) then) =
      _$SwapCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo? tradeInfo});

  $TradeInfoCopyWith<$Res>? get tradeInfo;
}

/// @nodoc
class _$SwapCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $SwapCopyWith<$Res> {
  _$SwapCopyWithImpl(Swap _value, $Res Function(Swap) _then)
      : super(_value, (v) => _then(v as Swap));

  @override
  Swap get _value => super._value as Swap;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
    Object? tradeInfo = freezed,
  }) {
    return _then(Swap(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: txHash == freezed
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: blockNumber == freezed
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tradeInfo: tradeInfo == freezed
          ? _value.tradeInfo
          : tradeInfo // ignore: cast_nullable_to_non_nullable
              as TradeInfo?,
    ));
  }

  @override
  $TradeInfoCopyWith<$Res>? get tradeInfo {
    if (_value.tradeInfo == null) {
      return null;
    }

    return $TradeInfoCopyWith<$Res>(_value.tradeInfo!, (value) {
      return _then(_value.copyWith(tradeInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable()
class _$Swap extends Swap with DiagnosticableTreeMixin {
  const _$Swap(
      {required this.timestamp = null,
      @JsonKey(name: '_id') required this.id,
      required this.name = 'swapTokens',
      this.txHash = null,
      required this.status,
      required this.blockNumber,
      @JsonKey(name: 'metadata') this.tradeInfo = null})
      : super._();

  factory _$Swap.fromJson(Map<String, dynamic> json) => _$_$SwapFromJson(json);

  @JsonKey(defaultValue: null)
  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: 'swapTokens')
  @override
  final String name;
  @JsonKey(defaultValue: null)
  @override
  final String? txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  @JsonKey(name: 'metadata')
  final TradeInfo? tradeInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.swap(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tradeInfo: $tradeInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.swap'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tradeInfo', tradeInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Swap &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.tradeInfo, tradeInfo) ||
                const DeepCollectionEquality()
                    .equals(other.tradeInfo, tradeInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tradeInfo);

  @JsonKey(ignore: true)
  @override
  $SwapCopyWith<Swap> get copyWith =>
      _$SwapCopyWithImpl<Swap>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        fiatDeposit,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)
        joinCommunity,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)
        bonus,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        send,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receive,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)
        swap,
  }) {
    return swap(timestamp, id, name, txHash, status, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        fiatDeposit,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String? communityName)?
        joinCommunity,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String? bonusType)?
        bonus,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        send,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receive,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo? tradeInfo)?
        swap,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(timestamp, id, name, txHash, status, blockNumber, tradeInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(JoinCommunity value) joinCommunity,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
  }) {
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(JoinCommunity value)? joinCommunity,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$SwapToJson(this)..['runtimeType'] = 'swap';
  }
}

abstract class Swap extends WalletAction {
  const factory Swap(
      {required int timestamp,
      @JsonKey(name: '_id') required String id,
      required String name,
      String? txHash,
      required String status,
      required int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo? tradeInfo}) = _$Swap;
  const Swap._() : super._();

  factory Swap.fromJson(Map<String, dynamic> json) = _$Swap.fromJson;

  @override
  int get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get txHash => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get blockNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'metadata')
  TradeInfo? get tradeInfo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SwapCopyWith<Swap> get copyWith => throw _privateConstructorUsedError;
}

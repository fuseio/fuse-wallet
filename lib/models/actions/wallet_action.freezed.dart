// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletAction _$WalletActionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'createWallet':
      return CreateWallet.fromJson(json);
    case 'fiatDeposit':
      return FiatDeposit.fromJson(json);
    case 'bonus':
      return Bonus.fromJson(json);
    case 'send':
      return Send.fromJson(json);
    case 'receive':
      return Receive.fromJson(json);
    case 'swap':
      return Swap.fromJson(json);
    case 'receiveNFT':
      return ReceiveNFT.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WalletAction',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$WalletAction {
  int get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get txHash => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get blockNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
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
      int? blockNumber});
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
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$CreateWalletCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$CreateWalletCopyWith(
          _$CreateWallet value, $Res Function(_$CreateWallet) then) =
      __$$CreateWalletCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber});
}

/// @nodoc
class __$$CreateWalletCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res>
    implements _$$CreateWalletCopyWith<$Res> {
  __$$CreateWalletCopyWithImpl(
      _$CreateWallet _value, $Res Function(_$CreateWallet) _then)
      : super(_value, (v) => _then(v as _$CreateWallet));

  @override
  _$CreateWallet get _value => super._value as _$CreateWallet;

  @override
  $Res call({
    Object? timestamp = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? txHash = freezed,
    Object? status = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_$CreateWallet(
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
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateWallet extends CreateWallet with DiagnosticableTreeMixin {
  const _$CreateWallet(
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'createWallet',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      final String? $type})
      : $type = $type ?? 'createWallet',
        super._();

  factory _$CreateWallet.fromJson(Map<String, dynamic> json) =>
      _$$CreateWalletFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$CreateWallet &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber));

  @JsonKey(ignore: true)
  @override
  _$$CreateWalletCopyWith<_$CreateWallet> get copyWith =>
      __$$CreateWalletCopyWithImpl<_$CreateWallet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return createWallet(timestamp, id, name, txHash, status, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return createWallet?.call(timestamp, id, name, txHash, status, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return createWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return createWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (createWallet != null) {
      return createWallet(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateWalletToJson(
      this,
    );
  }
}

abstract class CreateWallet extends WalletAction {
  const factory CreateWallet(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber}) = _$CreateWallet;
  const CreateWallet._() : super._();

  factory CreateWallet.fromJson(Map<String, dynamic> json) =
      _$CreateWallet.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  @override
  @JsonKey(ignore: true)
  _$$CreateWalletCopyWith<_$CreateWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FiatDepositCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$FiatDepositCopyWith(
          _$FiatDeposit value, $Res Function(_$FiatDeposit) then) =
      __$$FiatDepositCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      String tokenAddress,
      String? from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class __$$FiatDepositCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$FiatDepositCopyWith<$Res> {
  __$$FiatDepositCopyWithImpl(
      _$FiatDeposit _value, $Res Function(_$FiatDeposit) _then)
      : super(_value, (v) => _then(v as _$FiatDeposit));

  @override
  _$FiatDeposit get _value => super._value as _$FiatDeposit;

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
    return _then(_$FiatDeposit(
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
              as int?,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'fiat-deposit',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      required this.tokenAddress,
      this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      final String? $type})
      : $type = $type ?? 'fiatDeposit',
        super._();

  factory _$FiatDeposit.fromJson(Map<String, dynamic> json) =>
      _$$FiatDepositFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  final String tokenAddress;
  @override
  final String? from;
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

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$FiatDeposit &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.tokenName, tokenName) &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality()
                .equals(other.tokenDecimal, tokenDecimal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(tokenName),
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(tokenDecimal));

  @JsonKey(ignore: true)
  @override
  _$$FiatDepositCopyWith<_$FiatDeposit> get copyWith =>
      __$$FiatDepositCopyWithImpl<_$FiatDeposit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return fiatDeposit(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return fiatDeposit?.call(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return fiatDeposit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return fiatDeposit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (fiatDeposit != null) {
      return fiatDeposit(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FiatDepositToJson(
      this,
    );
  }
}

abstract class FiatDeposit extends WalletAction {
  const factory FiatDeposit(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      required final String tokenAddress,
      final String? from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal}) = _$FiatDeposit;
  const FiatDeposit._() : super._();

  factory FiatDeposit.fromJson(Map<String, dynamic> json) =
      _$FiatDeposit.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  String get tokenAddress;
  String? get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  _$$FiatDepositCopyWith<_$FiatDeposit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BonusCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$BonusCopyWith(_$Bonus value, $Res Function(_$Bonus) then) =
      __$$BonusCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      String tokenAddress,
      String? from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      String? bonusType});
}

/// @nodoc
class __$$BonusCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$BonusCopyWith<$Res> {
  __$$BonusCopyWithImpl(_$Bonus _value, $Res Function(_$Bonus) _then)
      : super(_value, (v) => _then(v as _$Bonus));

  @override
  _$Bonus get _value => super._value as _$Bonus;

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
    return _then(_$Bonus(
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
              as int?,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'tokenBonus',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      required this.tokenAddress,
      this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.bonusType,
      final String? $type})
      : $type = $type ?? 'bonus',
        super._();

  factory _$Bonus.fromJson(Map<String, dynamic> json) => _$$BonusFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  final String tokenAddress;
  @override
  final String? from;
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
  final String? bonusType;

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$Bonus &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.tokenName, tokenName) &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality()
                .equals(other.tokenDecimal, tokenDecimal) &&
            const DeepCollectionEquality().equals(other.bonusType, bonusType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(tokenName),
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(tokenDecimal),
      const DeepCollectionEquality().hash(bonusType));

  @JsonKey(ignore: true)
  @override
  _$$BonusCopyWith<_$Bonus> get copyWith =>
      __$$BonusCopyWithImpl<_$Bonus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return bonus(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal, bonusType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return bonus?.call(
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

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return bonus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return bonus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (bonus != null) {
      return bonus(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusToJson(
      this,
    );
  }
}

abstract class Bonus extends WalletAction {
  const factory Bonus(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      required final String tokenAddress,
      final String? from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final String? bonusType}) = _$Bonus;
  const Bonus._() : super._();

  factory Bonus.fromJson(Map<String, dynamic> json) = _$Bonus.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  String get tokenAddress;
  String? get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  String? get bonusType;
  @override
  @JsonKey(ignore: true)
  _$$BonusCopyWith<_$Bonus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$SendCopyWith(_$Send value, $Res Function(_$Send) then) =
      __$$SendCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class __$$SendCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$SendCopyWith<$Res> {
  __$$SendCopyWithImpl(_$Send _value, $Res Function(_$Send) _then)
      : super(_value, (v) => _then(v as _$Send));

  @override
  _$Send get _value => super._value as _$Send;

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
    return _then(_$Send(
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
              as int?,
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
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'sendTokens',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      final String? $type})
      : $type = $type ?? 'send',
        super._();

  factory _$Send.fromJson(Map<String, dynamic> json) => _$$SendFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
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

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$Send &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.tokenName, tokenName) &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality()
                .equals(other.tokenDecimal, tokenDecimal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(tokenName),
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(tokenDecimal));

  @JsonKey(ignore: true)
  @override
  _$$SendCopyWith<_$Send> get copyWith =>
      __$$SendCopyWithImpl<_$Send>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return send(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return send?.call(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return send?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendToJson(
      this,
    );
  }
}

abstract class Send extends WalletAction {
  const factory Send(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal}) = _$Send;
  const Send._() : super._();

  factory Send.fromJson(Map<String, dynamic> json) = _$Send.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  _$$SendCopyWith<_$Send> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReceiveCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$ReceiveCopyWith(_$Receive value, $Res Function(_$Receive) then) =
      __$$ReceiveCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class __$$ReceiveCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$ReceiveCopyWith<$Res> {
  __$$ReceiveCopyWithImpl(_$Receive _value, $Res Function(_$Receive) _then)
      : super(_value, (v) => _then(v as _$Receive));

  @override
  _$Receive get _value => super._value as _$Receive;

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
    return _then(_$Receive(
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
              as int?,
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
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'receiveTokens',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      final String? $type})
      : $type = $type ?? 'receive',
        super._();

  factory _$Receive.fromJson(Map<String, dynamic> json) =>
      _$$ReceiveFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
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

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$Receive &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.tokenName, tokenName) &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality()
                .equals(other.tokenDecimal, tokenDecimal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(tokenName),
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(tokenDecimal));

  @JsonKey(ignore: true)
  @override
  _$$ReceiveCopyWith<_$Receive> get copyWith =>
      __$$ReceiveCopyWithImpl<_$Receive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return receive(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return receive?.call(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return receive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return receive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receive != null) {
      return receive(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiveToJson(
      this,
    );
  }
}

abstract class Receive extends WalletAction {
  const factory Receive(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal}) = _$Receive;
  const Receive._() : super._();

  factory Receive.fromJson(Map<String, dynamic> json) = _$Receive.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  _$$ReceiveCopyWith<_$Receive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SwapCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$SwapCopyWith(_$Swap value, $Res Function(_$Swap) then) =
      __$$SwapCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      @JsonKey(name: 'metadata') Trade? tradeInfo});

  $TradeCopyWith<$Res>? get tradeInfo;
}

/// @nodoc
class __$$SwapCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$SwapCopyWith<$Res> {
  __$$SwapCopyWithImpl(_$Swap _value, $Res Function(_$Swap) _then)
      : super(_value, (v) => _then(v as _$Swap));

  @override
  _$Swap get _value => super._value as _$Swap;

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
    return _then(_$Swap(
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
              as int?,
      tradeInfo: tradeInfo == freezed
          ? _value.tradeInfo
          : tradeInfo // ignore: cast_nullable_to_non_nullable
              as Trade?,
    ));
  }

  @override
  $TradeCopyWith<$Res>? get tradeInfo {
    if (_value.tradeInfo == null) {
      return null;
    }

    return $TradeCopyWith<$Res>(_value.tradeInfo!, (value) {
      return _then(_value.copyWith(tradeInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Swap extends Swap with DiagnosticableTreeMixin {
  const _$Swap(
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'swapTokens',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      @JsonKey(name: 'metadata') this.tradeInfo,
      final String? $type})
      : $type = $type ?? 'swap',
        super._();

  factory _$Swap.fromJson(Map<String, dynamic> json) => _$$SwapFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  @JsonKey(name: 'metadata')
  final Trade? tradeInfo;

  @JsonKey(name: 'runtimeType')
  final String $type;

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
        (other.runtimeType == runtimeType &&
            other is _$Swap &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality().equals(other.tradeInfo, tradeInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tradeInfo));

  @JsonKey(ignore: true)
  @override
  _$$SwapCopyWith<_$Swap> get copyWith =>
      __$$SwapCopyWithImpl<_$Swap>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return swap(timestamp, id, name, txHash, status, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return swap?.call(
        timestamp, id, name, txHash, status, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
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
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return swap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapToJson(
      this,
    );
  }
}

abstract class Swap extends WalletAction {
  const factory Swap(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      @JsonKey(name: 'metadata') final Trade? tradeInfo}) = _$Swap;
  const Swap._() : super._();

  factory Swap.fromJson(Map<String, dynamic> json) = _$Swap.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  @JsonKey(name: 'metadata')
  Trade? get tradeInfo;
  @override
  @JsonKey(ignore: true)
  _$$SwapCopyWith<_$Swap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReceiveNFTCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$ReceiveNFTCopyWith(
          _$ReceiveNFT value, $Res Function(_$ReceiveNFT) then) =
      __$$ReceiveNFTCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String? txHash,
      String status,
      int? blockNumber,
      String tokenAddress,
      String from,
      String to,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal});
}

/// @nodoc
class __$$ReceiveNFTCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements _$$ReceiveNFTCopyWith<$Res> {
  __$$ReceiveNFTCopyWithImpl(
      _$ReceiveNFT _value, $Res Function(_$ReceiveNFT) _then)
      : super(_value, (v) => _then(v as _$ReceiveNFT));

  @override
  _$ReceiveNFT get _value => super._value as _$ReceiveNFT;

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
    Object? tokenName = freezed,
    Object? tokenSymbol = freezed,
    Object? tokenDecimal = freezed,
  }) {
    return _then(_$ReceiveNFT(
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
              as int?,
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
class _$ReceiveNFT extends ReceiveNFT with DiagnosticableTreeMixin {
  const _$ReceiveNFT(
      {this.timestamp = 0,
      @JsonKey(name: '_id') required this.id,
      this.name = 'receiveNFT',
      this.txHash,
      required this.status,
      this.blockNumber = 0,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      final String? $type})
      : $type = $type ?? 'receiveNFT',
        super._();

  factory _$ReceiveNFT.fromJson(Map<String, dynamic> json) =>
      _$$ReceiveNFTFromJson(json);

  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  final String status;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.receiveNFT(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.receiveNFT'))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiveNFT &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.txHash, txHash) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockNumber, blockNumber) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.tokenName, tokenName) &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality()
                .equals(other.tokenDecimal, tokenDecimal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(txHash),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockNumber),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(tokenName),
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(tokenDecimal));

  @JsonKey(ignore: true)
  @override
  _$$ReceiveNFTCopyWith<_$ReceiveNFT> get copyWith =>
      __$$ReceiveNFTCopyWithImpl<_$ReceiveNFT>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)
        createWallet,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)
        receiveNFT,
  }) {
    return receiveNFT(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
  }) {
    return receiveNFT?.call(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, @JsonKey(name: '_id') String id,
            String name, String? txHash, String status, int? blockNumber)?
        createWallet,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
            String tokenAddress,
            String? from,
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
            int? blockNumber,
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
            int? blockNumber,
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
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String? txHash,
            String status,
            int? blockNumber,
            String tokenAddress,
            String from,
            String to,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal)?
        receiveNFT,
    required TResult orElse(),
  }) {
    if (receiveNFT != null) {
      return receiveNFT(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(Receive value) receive,
    required TResult Function(Swap value) swap,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return receiveNFT(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
  }) {
    return receiveNFT?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(Receive value)? receive,
    TResult Function(Swap value)? swap,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receiveNFT != null) {
      return receiveNFT(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiveNFTToJson(
      this,
    );
  }
}

abstract class ReceiveNFT extends WalletAction {
  const factory ReceiveNFT(
      {final int timestamp,
      @JsonKey(name: '_id') required final String id,
      final String name,
      final String? txHash,
      required final String status,
      final int? blockNumber,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal}) = _$ReceiveNFT;
  const ReceiveNFT._() : super._();

  factory ReceiveNFT.fromJson(Map<String, dynamic> json) =
      _$ReceiveNFT.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  String get status;
  @override
  int? get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  _$$ReceiveNFTCopyWith<_$ReceiveNFT> get copyWith =>
      throw _privateConstructorUsedError;
}

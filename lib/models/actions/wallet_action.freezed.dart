// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'wallet_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
WalletAction _$WalletActionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'createWallet':
      return CreateWallet.fromJson(json);
    case 'fiatProcess':
      return FiatProcess.fromJson(json);
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

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$WalletActionTearOff {
  const _$WalletActionTearOff();

// ignore: unused_element
  CreateWallet createWallet(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber}) {
    return CreateWallet(
      timestamp: timestamp,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
    );
  }

// ignore: unused_element
  FiatProcess fiatProcess(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) {
    return FiatProcess(
      timestamp: timestamp,
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

// ignore: unused_element
  FiatDeposit fiatDeposit(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenSymbol,
      String tokenName,
      int tokenDecimal}) {
    return FiatDeposit(
      timestamp: timestamp,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      tokenAddress: tokenAddress,
      from: from,
      to: to,
      value: value,
      tokenSymbol: tokenSymbol,
      tokenName: tokenName,
      tokenDecimal: tokenDecimal,
    );
  }

// ignore: unused_element
  JoinCommunity joinCommunity(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress}) {
    return JoinCommunity(
      timestamp: timestamp,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
      communityAddress: communityAddress,
      tokenAddress: tokenAddress,
    );
  }

// ignore: unused_element
  Bonus bonus(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      String bonusType}) {
    return Bonus(
      timestamp: timestamp,
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

// ignore: unused_element
  Send send(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) {
    return Send(
      timestamp: timestamp,
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

// ignore: unused_element
  Receive receive(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) {
    return Receive(
      timestamp: timestamp,
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

// ignore: unused_element
  WalletAction fromJson(Map<String, Object> json) {
    return WalletAction.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $WalletAction = _$WalletActionTearOff();

/// @nodoc
mixin _$WalletAction {
  int get timestamp;
  String get name;
  String get txHash;
  String get status;
  int get blockNumber;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  });
  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $WalletActionCopyWith<WalletAction> get copyWith;
}

/// @nodoc
abstract class $WalletActionCopyWith<$Res> {
  factory $WalletActionCopyWith(
          WalletAction value, $Res Function(WalletAction) then) =
      _$WalletActionCopyWithImpl<$Res>;
  $Res call(
      {int timestamp,
      String name,
      String txHash,
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
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
      String name,
      String txHash,
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
  }) {
    return _then(CreateWallet(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$CreateWallet extends CreateWallet {
  const _$CreateWallet(
      {this.timestamp, this.name, this.txHash, this.status, this.blockNumber})
      : super._();

  factory _$CreateWallet.fromJson(Map<String, dynamic> json) =>
      _$_$CreateWalletFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
  @override
  final String status;
  @override
  final int blockNumber;

  @override
  String toString() {
    return 'WalletAction.createWallet(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateWallet &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return createWallet(timestamp, name, txHash, status, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (createWallet != null) {
      return createWallet(timestamp, name, txHash, status, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return createWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const CreateWallet._() : super._();
  const factory CreateWallet(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber}) = _$CreateWallet;

  factory CreateWallet.fromJson(Map<String, dynamic> json) =
      _$CreateWallet.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  @override
  @JsonKey(ignore: true)
  $CreateWalletCopyWith<CreateWallet> get copyWith;
}

/// @nodoc
abstract class $FiatProcessCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory $FiatProcessCopyWith(
          FiatProcess value, $Res Function(FiatProcess) then) =
      _$FiatProcessCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      String name,
      String txHash,
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
class _$FiatProcessCopyWithImpl<$Res> extends _$WalletActionCopyWithImpl<$Res>
    implements $FiatProcessCopyWith<$Res> {
  _$FiatProcessCopyWithImpl(
      FiatProcess _value, $Res Function(FiatProcess) _then)
      : super(_value, (v) => _then(v as FiatProcess));

  @override
  FiatProcess get _value => super._value as FiatProcess;

  @override
  $Res call({
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tokenAddress = freezed,
    Object from = freezed,
    Object to = freezed,
    Object value = freezed,
    Object tokenName = freezed,
    Object tokenSymbol = freezed,
    Object tokenDecimal = freezed,
  }) {
    return _then(FiatProcess(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
      from: from == freezed ? _value.from : from as String,
      to: to == freezed ? _value.to : to as String,
      value: value == freezed ? _value.value : value as BigInt,
      tokenName: tokenName == freezed ? _value.tokenName : tokenName as String,
      tokenSymbol:
          tokenSymbol == freezed ? _value.tokenSymbol : tokenSymbol as String,
      tokenDecimal:
          tokenDecimal == freezed ? _value.tokenDecimal : tokenDecimal as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$FiatProcess extends FiatProcess {
  const _$FiatProcess(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.tokenAddress,
      this.from,
      this.to,
      this.value,
      this.tokenName,
      this.tokenSymbol,
      this.tokenDecimal})
      : super._();

  factory _$FiatProcess.fromJson(Map<String, dynamic> json) =>
      _$_$FiatProcessFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
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
  String toString() {
    return 'WalletAction.fiatProcess(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FiatProcess &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
  $FiatProcessCopyWith<FiatProcess> get copyWith =>
      _$FiatProcessCopyWithImpl<FiatProcess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return fiatProcess(timestamp, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (fiatProcess != null) {
      return fiatProcess(timestamp, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return fiatProcess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (fiatProcess != null) {
      return fiatProcess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$FiatProcessToJson(this)..['runtimeType'] = 'fiatProcess';
  }
}

abstract class FiatProcess extends WalletAction {
  const FiatProcess._() : super._();
  const factory FiatProcess(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) = _$FiatProcess;

  factory FiatProcess.fromJson(Map<String, dynamic> json) =
      _$FiatProcess.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  $FiatProcessCopyWith<FiatProcess> get copyWith;
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
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenSymbol,
      String tokenName,
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tokenAddress = freezed,
    Object from = freezed,
    Object to = freezed,
    Object value = freezed,
    Object tokenSymbol = freezed,
    Object tokenName = freezed,
    Object tokenDecimal = freezed,
  }) {
    return _then(FiatDeposit(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
      from: from == freezed ? _value.from : from as String,
      to: to == freezed ? _value.to : to as String,
      value: value == freezed ? _value.value : value as BigInt,
      tokenSymbol:
          tokenSymbol == freezed ? _value.tokenSymbol : tokenSymbol as String,
      tokenName: tokenName == freezed ? _value.tokenName : tokenName as String,
      tokenDecimal:
          tokenDecimal == freezed ? _value.tokenDecimal : tokenDecimal as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$FiatDeposit extends FiatDeposit {
  const _$FiatDeposit(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.tokenAddress,
      this.from,
      this.to,
      this.value,
      this.tokenSymbol,
      this.tokenName,
      this.tokenDecimal})
      : super._();

  factory _$FiatDeposit.fromJson(Map<String, dynamic> json) =>
      _$_$FiatDepositFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
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
  final String tokenSymbol;
  @override
  final String tokenName;
  @override
  final int tokenDecimal;

  @override
  String toString() {
    return 'WalletAction.fiatDeposit(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenSymbol: $tokenSymbol, tokenName: $tokenName, tokenDecimal: $tokenDecimal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FiatDeposit &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
            (identical(other.tokenSymbol, tokenSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.tokenSymbol, tokenSymbol)) &&
            (identical(other.tokenName, tokenName) ||
                const DeepCollectionEquality()
                    .equals(other.tokenName, tokenName)) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                const DeepCollectionEquality()
                    .equals(other.tokenDecimal, tokenDecimal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(tokenSymbol) ^
      const DeepCollectionEquality().hash(tokenName) ^
      const DeepCollectionEquality().hash(tokenDecimal);

  @JsonKey(ignore: true)
  @override
  $FiatDepositCopyWith<FiatDeposit> get copyWith =>
      _$FiatDepositCopyWithImpl<FiatDeposit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return fiatDeposit(timestamp, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenSymbol, tokenName, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (fiatDeposit != null) {
      return fiatDeposit(timestamp, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenSymbol, tokenName, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return fiatDeposit(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const FiatDeposit._() : super._();
  const factory FiatDeposit(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenSymbol,
      String tokenName,
      int tokenDecimal}) = _$FiatDeposit;

  factory FiatDeposit.fromJson(Map<String, dynamic> json) =
      _$FiatDeposit.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenSymbol;
  String get tokenName;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  $FiatDepositCopyWith<FiatDeposit> get copyWith;
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
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress});
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object communityAddress = freezed,
    Object tokenAddress = freezed,
  }) {
    return _then(JoinCommunity(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      communityAddress: communityAddress == freezed
          ? _value.communityAddress
          : communityAddress as String,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$JoinCommunity extends JoinCommunity {
  const _$JoinCommunity(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.communityAddress,
      this.tokenAddress})
      : super._();

  factory _$JoinCommunity.fromJson(Map<String, dynamic> json) =>
      _$_$JoinCommunityFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  final String communityAddress;
  @override
  final String tokenAddress;

  @override
  String toString() {
    return 'WalletAction.joinCommunity(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, communityAddress: $communityAddress, tokenAddress: $tokenAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JoinCommunity &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
                    .equals(other.tokenAddress, tokenAddress)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(txHash) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(communityAddress) ^
      const DeepCollectionEquality().hash(tokenAddress);

  @JsonKey(ignore: true)
  @override
  $JoinCommunityCopyWith<JoinCommunity> get copyWith =>
      _$JoinCommunityCopyWithImpl<JoinCommunity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return joinCommunity(timestamp, name, txHash, status, blockNumber,
        communityAddress, tokenAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (joinCommunity != null) {
      return joinCommunity(timestamp, name, txHash, status, blockNumber,
          communityAddress, tokenAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return joinCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const JoinCommunity._() : super._();
  const factory JoinCommunity(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress}) = _$JoinCommunity;

  factory JoinCommunity.fromJson(Map<String, dynamic> json) =
      _$JoinCommunity.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get communityAddress;
  String get tokenAddress;
  @override
  @JsonKey(ignore: true)
  $JoinCommunityCopyWith<JoinCommunity> get copyWith;
}

/// @nodoc
abstract class $BonusCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $BonusCopyWith(Bonus value, $Res Function(Bonus) then) =
      _$BonusCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      String bonusType});
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tokenAddress = freezed,
    Object from = freezed,
    Object to = freezed,
    Object value = freezed,
    Object tokenName = freezed,
    Object tokenSymbol = freezed,
    Object tokenDecimal = freezed,
    Object bonusType = freezed,
  }) {
    return _then(Bonus(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
      from: from == freezed ? _value.from : from as String,
      to: to == freezed ? _value.to : to as String,
      value: value == freezed ? _value.value : value as BigInt,
      tokenName: tokenName == freezed ? _value.tokenName : tokenName as String,
      tokenSymbol:
          tokenSymbol == freezed ? _value.tokenSymbol : tokenSymbol as String,
      tokenDecimal:
          tokenDecimal == freezed ? _value.tokenDecimal : tokenDecimal as int,
      bonusType: bonusType == freezed ? _value.bonusType : bonusType as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$Bonus extends Bonus {
  const _$Bonus(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.tokenAddress,
      this.from,
      this.to,
      this.value,
      this.tokenName,
      this.tokenSymbol,
      this.tokenDecimal,
      this.bonusType})
      : super._();

  factory _$Bonus.fromJson(Map<String, dynamic> json) =>
      _$_$BonusFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
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
  final String bonusType;

  @override
  String toString() {
    return 'WalletAction.bonus(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, bonusType: $bonusType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Bonus &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return bonus(timestamp, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal, bonusType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (bonus != null) {
      return bonus(timestamp, name, txHash, status, blockNumber, tokenAddress,
          from, to, value, tokenName, tokenSymbol, tokenDecimal, bonusType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return bonus(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const Bonus._() : super._();
  const factory Bonus(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      String bonusType}) = _$Bonus;

  factory Bonus.fromJson(Map<String, dynamic> json) = _$Bonus.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  String get bonusType;
  @override
  @JsonKey(ignore: true)
  $BonusCopyWith<Bonus> get copyWith;
}

/// @nodoc
abstract class $SendCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $SendCopyWith(Send value, $Res Function(Send) then) =
      _$SendCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      String name,
      String txHash,
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tokenAddress = freezed,
    Object from = freezed,
    Object to = freezed,
    Object value = freezed,
    Object tokenName = freezed,
    Object tokenSymbol = freezed,
    Object tokenDecimal = freezed,
  }) {
    return _then(Send(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
      from: from == freezed ? _value.from : from as String,
      to: to == freezed ? _value.to : to as String,
      value: value == freezed ? _value.value : value as BigInt,
      tokenName: tokenName == freezed ? _value.tokenName : tokenName as String,
      tokenSymbol:
          tokenSymbol == freezed ? _value.tokenSymbol : tokenSymbol as String,
      tokenDecimal:
          tokenDecimal == freezed ? _value.tokenDecimal : tokenDecimal as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$Send extends Send {
  const _$Send(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.tokenAddress,
      this.from,
      this.to,
      this.value,
      this.tokenName,
      this.tokenSymbol,
      this.tokenDecimal})
      : super._();

  factory _$Send.fromJson(Map<String, dynamic> json) => _$_$SendFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
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
  String toString() {
    return 'WalletAction.send(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Send &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return send(timestamp, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (send != null) {
      return send(timestamp, name, txHash, status, blockNumber, tokenAddress,
          from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const Send._() : super._();
  const factory Send(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) = _$Send;

  factory Send.fromJson(Map<String, dynamic> json) = _$Send.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  $SendCopyWith<Send> get copyWith;
}

/// @nodoc
abstract class $ReceiveCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $ReceiveCopyWith(Receive value, $Res Function(Receive) then) =
      _$ReceiveCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      String name,
      String txHash,
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
    Object timestamp = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tokenAddress = freezed,
    Object from = freezed,
    Object to = freezed,
    Object value = freezed,
    Object tokenName = freezed,
    Object tokenSymbol = freezed,
    Object tokenDecimal = freezed,
  }) {
    return _then(Receive(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress as String,
      from: from == freezed ? _value.from : from as String,
      to: to == freezed ? _value.to : to as String,
      value: value == freezed ? _value.value : value as BigInt,
      tokenName: tokenName == freezed ? _value.tokenName : tokenName as String,
      tokenSymbol:
          tokenSymbol == freezed ? _value.tokenSymbol : tokenSymbol as String,
      tokenDecimal:
          tokenDecimal == freezed ? _value.tokenDecimal : tokenDecimal as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$Receive extends Receive {
  const _$Receive(
      {this.timestamp,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.tokenAddress,
      this.from,
      this.to,
      this.value,
      this.tokenName,
      this.tokenSymbol,
      this.tokenDecimal})
      : super._();

  factory _$Receive.fromJson(Map<String, dynamic> json) =>
      _$_$ReceiveFromJson(json);

  @override
  final int timestamp;
  @override
  final String name;
  @override
  final String txHash;
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
  String toString() {
    return 'WalletAction.receive(timestamp: $timestamp, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Receive &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, String name, String txHash,
            String status, int blockNumber),
    @required
        TResult fiatProcess(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult fiatDeposit(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenSymbol,
            String tokenName,
            int tokenDecimal),
    @required
        TResult joinCommunity(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress),
    @required
        TResult bonus(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            String bonusType),
    @required
        TResult send(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
    @required
        TResult receive(
            int timestamp,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return receive(timestamp, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, String name, String txHash,
        String status, int blockNumber),
    TResult fiatProcess(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult fiatDeposit(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenSymbol,
        String tokenName,
        int tokenDecimal),
    TResult joinCommunity(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress),
    TResult bonus(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal,
        String bonusType),
    TResult send(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    TResult receive(
        int timestamp,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String tokenAddress,
        String from,
        String to,
        BigInt value,
        String tokenName,
        String tokenSymbol,
        int tokenDecimal),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (receive != null) {
      return receive(timestamp, name, txHash, status, blockNumber, tokenAddress,
          from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatProcess(FiatProcess value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
  }) {
    assert(createWallet != null);
    assert(fiatProcess != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    return receive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatProcess(FiatProcess value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const Receive._() : super._();
  const factory Receive(
      {int timestamp,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal}) = _$Receive;

  factory Receive.fromJson(Map<String, dynamic> json) = _$Receive.fromJson;

  @override
  int get timestamp;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  @JsonKey(ignore: true)
  $ReceiveCopyWith<Receive> get copyWith;
}

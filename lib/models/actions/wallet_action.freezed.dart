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

// ignore: unused_element
  CreateWallet createWallet(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber}) {
    return CreateWallet(
      timestamp: timestamp,
      id: id,
      name: name,
      txHash: txHash,
      status: status,
      blockNumber: blockNumber,
    );
  }

// ignore: unused_element
  FiatDeposit fiatDeposit(
      {int timestamp,
      @JsonKey(name: '_id') String id,
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
      id: id,
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
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress,
      String communityName}) {
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

// ignore: unused_element
  Bonus bonus(
      {int timestamp,
      @JsonKey(name: '_id') String id,
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

// ignore: unused_element
  Send send(
      {int timestamp,
      @JsonKey(name: '_id') String id,
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

// ignore: unused_element
  Receive receive(
      {int timestamp,
      @JsonKey(name: '_id') String id,
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

// ignore: unused_element
  Swap swap(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo tradeInfo}) {
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
  @JsonKey(name: '_id')
  String get id;
  String get name;
  String get txHash;
  String get status;
  int get blockNumber;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
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
    Object id = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      id: id == freezed ? _value.id : id as String,
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
      @JsonKey(name: '_id') String id,
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
    Object id = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
  }) {
    return _then(CreateWallet(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      id: id == freezed ? _value.id : id as String,
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
      {this.timestamp,
      @JsonKey(name: '_id') this.id,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber})
      : super._();

  factory _$CreateWallet.fromJson(Map<String, dynamic> json) =>
      _$_$CreateWalletFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
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
    return 'WalletAction.createWallet(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return createWallet(timestamp, id, name, txHash, status, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (createWallet != null) {
      return createWallet(timestamp, id, name, txHash, status, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return createWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber}) = _$CreateWallet;

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
    Object id = freezed,
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
      id: id == freezed ? _value.id : id as String,
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
      @JsonKey(name: '_id') this.id,
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
  @JsonKey(name: '_id')
  final String id;
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
    return 'WalletAction.fiatDeposit(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenSymbol: $tokenSymbol, tokenName: $tokenName, tokenDecimal: $tokenDecimal)';
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
      const DeepCollectionEquality().hash(id) ^
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
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return fiatDeposit(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenSymbol, tokenName, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (fiatDeposit != null) {
      return fiatDeposit(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenSymbol, tokenName, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return fiatDeposit(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
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
  @JsonKey(name: '_id')
  String get id;
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
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress,
      String communityName});
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
    Object id = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object communityAddress = freezed,
    Object tokenAddress = freezed,
    Object communityName = freezed,
  }) {
    return _then(JoinCommunity(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      id: id == freezed ? _value.id : id as String,
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
      communityName: communityName == freezed
          ? _value.communityName
          : communityName as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$JoinCommunity extends JoinCommunity {
  const _$JoinCommunity(
      {this.timestamp,
      @JsonKey(name: '_id') this.id,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      this.communityAddress,
      this.tokenAddress,
      this.communityName})
      : super._();

  factory _$JoinCommunity.fromJson(Map<String, dynamic> json) =>
      _$_$JoinCommunityFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
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
  final String communityName;

  @override
  String toString() {
    return 'WalletAction.joinCommunity(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, communityAddress: $communityAddress, tokenAddress: $tokenAddress, communityName: $communityName)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return joinCommunity(timestamp, id, name, txHash, status, blockNumber,
        communityAddress, tokenAddress, communityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (joinCommunity != null) {
      return joinCommunity(timestamp, id, name, txHash, status, blockNumber,
          communityAddress, tokenAddress, communityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return joinCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      String communityAddress,
      String tokenAddress,
      String communityName}) = _$JoinCommunity;

  factory JoinCommunity.fromJson(Map<String, dynamic> json) =
      _$JoinCommunity.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
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
  String get communityName;
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
      @JsonKey(name: '_id') String id,
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
    Object id = freezed,
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
      id: id == freezed ? _value.id : id as String,
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
      @JsonKey(name: '_id') this.id,
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
  @JsonKey(name: '_id')
  final String id;
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
    return 'WalletAction.bonus(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, bonusType: $bonusType)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return bonus(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal, bonusType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return bonus(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
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
  @JsonKey(name: '_id')
  String get id;
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
      @JsonKey(name: '_id') String id,
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
    Object id = freezed,
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
      id: id == freezed ? _value.id : id as String,
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
      @JsonKey(name: '_id') this.id,
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
  @JsonKey(name: '_id')
  final String id;
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
    return 'WalletAction.send(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return send(timestamp, id, name, txHash, status, blockNumber, tokenAddress,
        from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (send != null) {
      return send(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
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
  @JsonKey(name: '_id')
  String get id;
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
      @JsonKey(name: '_id') String id,
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
    Object id = freezed,
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
      id: id == freezed ? _value.id : id as String,
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
      @JsonKey(name: '_id') this.id,
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
  @JsonKey(name: '_id')
  final String id;
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
    return 'WalletAction.receive(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return receive(timestamp, id, name, txHash, status, blockNumber,
        tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (receive != null) {
      return receive(timestamp, id, name, txHash, status, blockNumber,
          tokenAddress, from, to, value, tokenName, tokenSymbol, tokenDecimal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return receive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
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
      @JsonKey(name: '_id') String id,
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
  @JsonKey(name: '_id')
  String get id;
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

/// @nodoc
abstract class $SwapCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory $SwapCopyWith(Swap value, $Res Function(Swap) then) =
      _$SwapCopyWithImpl<$Res>;
  @override
  $Res call(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo tradeInfo});

  $TradeInfoCopyWith<$Res> get tradeInfo;
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
    Object timestamp = freezed,
    Object id = freezed,
    Object name = freezed,
    Object txHash = freezed,
    Object status = freezed,
    Object blockNumber = freezed,
    Object tradeInfo = freezed,
  }) {
    return _then(Swap(
      timestamp: timestamp == freezed ? _value.timestamp : timestamp as int,
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      txHash: txHash == freezed ? _value.txHash : txHash as String,
      status: status == freezed ? _value.status : status as String,
      blockNumber:
          blockNumber == freezed ? _value.blockNumber : blockNumber as int,
      tradeInfo:
          tradeInfo == freezed ? _value.tradeInfo : tradeInfo as TradeInfo,
    ));
  }

  @override
  $TradeInfoCopyWith<$Res> get tradeInfo {
    if (_value.tradeInfo == null) {
      return null;
    }
    return $TradeInfoCopyWith<$Res>(_value.tradeInfo, (value) {
      return _then(_value.copyWith(tradeInfo: value));
    });
  }
}

@JsonSerializable()

/// @nodoc
class _$Swap extends Swap {
  const _$Swap(
      {this.timestamp,
      @JsonKey(name: '_id') this.id,
      this.name,
      this.txHash,
      this.status,
      this.blockNumber,
      @JsonKey(name: 'metadata') this.tradeInfo})
      : super._();

  factory _$Swap.fromJson(Map<String, dynamic> json) => _$_$SwapFromJson(json);

  @override
  final int timestamp;
  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String txHash;
  @override
  final String status;
  @override
  final int blockNumber;
  @override
  @JsonKey(name: 'metadata')
  final TradeInfo tradeInfo;

  @override
  String toString() {
    return 'WalletAction.swap(timestamp: $timestamp, id: $id, name: $name, txHash: $txHash, status: $status, blockNumber: $blockNumber, tradeInfo: $tradeInfo)';
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
  TResult when<TResult extends Object>({
    @required
        TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
            String name, String txHash, String status, int blockNumber),
    @required
        TResult fiatDeposit(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            String communityAddress,
            String tokenAddress,
            String communityName),
    @required
        TResult bonus(
            int timestamp,
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
            @JsonKey(name: '_id') String id,
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
        TResult swap(
            int timestamp,
            @JsonKey(name: '_id') String id,
            String name,
            String txHash,
            String status,
            int blockNumber,
            @JsonKey(name: 'metadata') TradeInfo tradeInfo),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return swap(timestamp, id, name, txHash, status, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult createWallet(int timestamp, @JsonKey(name: '_id') String id,
        String name, String txHash, String status, int blockNumber),
    TResult fiatDeposit(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        String communityAddress,
        String tokenAddress,
        String communityName),
    TResult bonus(
        int timestamp,
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
        @JsonKey(name: '_id') String id,
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
    TResult swap(
        int timestamp,
        @JsonKey(name: '_id') String id,
        String name,
        String txHash,
        String status,
        int blockNumber,
        @JsonKey(name: 'metadata') TradeInfo tradeInfo),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (swap != null) {
      return swap(timestamp, id, name, txHash, status, blockNumber, tradeInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult createWallet(CreateWallet value),
    @required TResult fiatDeposit(FiatDeposit value),
    @required TResult joinCommunity(JoinCommunity value),
    @required TResult bonus(Bonus value),
    @required TResult send(Send value),
    @required TResult receive(Receive value),
    @required TResult swap(Swap value),
  }) {
    assert(createWallet != null);
    assert(fiatDeposit != null);
    assert(joinCommunity != null);
    assert(bonus != null);
    assert(send != null);
    assert(receive != null);
    assert(swap != null);
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult createWallet(CreateWallet value),
    TResult fiatDeposit(FiatDeposit value),
    TResult joinCommunity(JoinCommunity value),
    TResult bonus(Bonus value),
    TResult send(Send value),
    TResult receive(Receive value),
    TResult swap(Swap value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
  const Swap._() : super._();
  const factory Swap(
      {int timestamp,
      @JsonKey(name: '_id') String id,
      String name,
      String txHash,
      String status,
      int blockNumber,
      @JsonKey(name: 'metadata') TradeInfo tradeInfo}) = _$Swap;

  factory Swap.fromJson(Map<String, dynamic> json) = _$Swap.fromJson;

  @override
  int get timestamp;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get txHash;
  @override
  String get status;
  @override
  int get blockNumber;
  @JsonKey(name: 'metadata')
  TradeInfo get tradeInfo;
  @override
  @JsonKey(ignore: true)
  $SwapCopyWith<Swap> get copyWith;
}

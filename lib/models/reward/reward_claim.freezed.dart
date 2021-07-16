// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'reward_claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RewardClaim _$RewardClaimFromJson(Map<String, dynamic> json) {
  return _RewardClaim.fromJson(json);
}

/// @nodoc
class _$RewardClaimTearOff {
  const _$RewardClaimTearOff();

  _RewardClaim call(
      {required String amount,
      required double humanAmount,
      required bool isClaimed,
      required String walletAddress,
      required String tokenAddress,
      required int syncTimestamp,
      required int syncBlockNumber,
      required int nextClaimTimestamp,
      required DateTime createdAt,
      required DateTime updatedAt,
      @JsonKey(name: '_id') required String id}) {
    return _RewardClaim(
      amount: amount,
      humanAmount: humanAmount,
      isClaimed: isClaimed,
      walletAddress: walletAddress,
      tokenAddress: tokenAddress,
      syncTimestamp: syncTimestamp,
      syncBlockNumber: syncBlockNumber,
      nextClaimTimestamp: nextClaimTimestamp,
      createdAt: createdAt,
      updatedAt: updatedAt,
      id: id,
    );
  }

  RewardClaim fromJson(Map<String, Object> json) {
    return RewardClaim.fromJson(json);
  }
}

/// @nodoc
const $RewardClaim = _$RewardClaimTearOff();

/// @nodoc
mixin _$RewardClaim {
  String get amount => throw _privateConstructorUsedError;
  double get humanAmount => throw _privateConstructorUsedError;
  bool get isClaimed => throw _privateConstructorUsedError;
  String get walletAddress => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  int get syncTimestamp => throw _privateConstructorUsedError;
  int get syncBlockNumber => throw _privateConstructorUsedError;
  int get nextClaimTimestamp => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardClaimCopyWith<RewardClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardClaimCopyWith<$Res> {
  factory $RewardClaimCopyWith(
          RewardClaim value, $Res Function(RewardClaim) then) =
      _$RewardClaimCopyWithImpl<$Res>;
  $Res call(
      {String amount,
      double humanAmount,
      bool isClaimed,
      String walletAddress,
      String tokenAddress,
      int syncTimestamp,
      int syncBlockNumber,
      int nextClaimTimestamp,
      DateTime createdAt,
      DateTime updatedAt,
      @JsonKey(name: '_id') String id});
}

/// @nodoc
class _$RewardClaimCopyWithImpl<$Res> implements $RewardClaimCopyWith<$Res> {
  _$RewardClaimCopyWithImpl(this._value, this._then);

  final RewardClaim _value;
  // ignore: unused_field
  final $Res Function(RewardClaim) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? humanAmount = freezed,
    Object? isClaimed = freezed,
    Object? walletAddress = freezed,
    Object? tokenAddress = freezed,
    Object? syncTimestamp = freezed,
    Object? syncBlockNumber = freezed,
    Object? nextClaimTimestamp = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      humanAmount: humanAmount == freezed
          ? _value.humanAmount
          : humanAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isClaimed: isClaimed == freezed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      syncTimestamp: syncTimestamp == freezed
          ? _value.syncTimestamp
          : syncTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      syncBlockNumber: syncBlockNumber == freezed
          ? _value.syncBlockNumber
          : syncBlockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      nextClaimTimestamp: nextClaimTimestamp == freezed
          ? _value.nextClaimTimestamp
          : nextClaimTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RewardClaimCopyWith<$Res>
    implements $RewardClaimCopyWith<$Res> {
  factory _$RewardClaimCopyWith(
          _RewardClaim value, $Res Function(_RewardClaim) then) =
      __$RewardClaimCopyWithImpl<$Res>;
  @override
  $Res call(
      {String amount,
      double humanAmount,
      bool isClaimed,
      String walletAddress,
      String tokenAddress,
      int syncTimestamp,
      int syncBlockNumber,
      int nextClaimTimestamp,
      DateTime createdAt,
      DateTime updatedAt,
      @JsonKey(name: '_id') String id});
}

/// @nodoc
class __$RewardClaimCopyWithImpl<$Res> extends _$RewardClaimCopyWithImpl<$Res>
    implements _$RewardClaimCopyWith<$Res> {
  __$RewardClaimCopyWithImpl(
      _RewardClaim _value, $Res Function(_RewardClaim) _then)
      : super(_value, (v) => _then(v as _RewardClaim));

  @override
  _RewardClaim get _value => super._value as _RewardClaim;

  @override
  $Res call({
    Object? amount = freezed,
    Object? humanAmount = freezed,
    Object? isClaimed = freezed,
    Object? walletAddress = freezed,
    Object? tokenAddress = freezed,
    Object? syncTimestamp = freezed,
    Object? syncBlockNumber = freezed,
    Object? nextClaimTimestamp = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? id = freezed,
  }) {
    return _then(_RewardClaim(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      humanAmount: humanAmount == freezed
          ? _value.humanAmount
          : humanAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isClaimed: isClaimed == freezed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: walletAddress == freezed
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      syncTimestamp: syncTimestamp == freezed
          ? _value.syncTimestamp
          : syncTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      syncBlockNumber: syncBlockNumber == freezed
          ? _value.syncBlockNumber
          : syncBlockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      nextClaimTimestamp: nextClaimTimestamp == freezed
          ? _value.nextClaimTimestamp
          : nextClaimTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_RewardClaim implements _RewardClaim {
  _$_RewardClaim(
      {required this.amount,
      required this.humanAmount,
      required this.isClaimed,
      required this.walletAddress,
      required this.tokenAddress,
      required this.syncTimestamp,
      required this.syncBlockNumber,
      required this.nextClaimTimestamp,
      required this.createdAt,
      required this.updatedAt,
      @JsonKey(name: '_id') required this.id});

  factory _$_RewardClaim.fromJson(Map<String, dynamic> json) =>
      _$_$_RewardClaimFromJson(json);

  @override
  final String amount;
  @override
  final double humanAmount;
  @override
  final bool isClaimed;
  @override
  final String walletAddress;
  @override
  final String tokenAddress;
  @override
  final int syncTimestamp;
  @override
  final int syncBlockNumber;
  @override
  final int nextClaimTimestamp;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey(name: '_id')
  final String id;

  @override
  String toString() {
    return 'RewardClaim(amount: $amount, humanAmount: $humanAmount, isClaimed: $isClaimed, walletAddress: $walletAddress, tokenAddress: $tokenAddress, syncTimestamp: $syncTimestamp, syncBlockNumber: $syncBlockNumber, nextClaimTimestamp: $nextClaimTimestamp, createdAt: $createdAt, updatedAt: $updatedAt, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RewardClaim &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.humanAmount, humanAmount) ||
                const DeepCollectionEquality()
                    .equals(other.humanAmount, humanAmount)) &&
            (identical(other.isClaimed, isClaimed) ||
                const DeepCollectionEquality()
                    .equals(other.isClaimed, isClaimed)) &&
            (identical(other.walletAddress, walletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.walletAddress, walletAddress)) &&
            (identical(other.tokenAddress, tokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.tokenAddress, tokenAddress)) &&
            (identical(other.syncTimestamp, syncTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.syncTimestamp, syncTimestamp)) &&
            (identical(other.syncBlockNumber, syncBlockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.syncBlockNumber, syncBlockNumber)) &&
            (identical(other.nextClaimTimestamp, nextClaimTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.nextClaimTimestamp, nextClaimTimestamp)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(humanAmount) ^
      const DeepCollectionEquality().hash(isClaimed) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      const DeepCollectionEquality().hash(tokenAddress) ^
      const DeepCollectionEquality().hash(syncTimestamp) ^
      const DeepCollectionEquality().hash(syncBlockNumber) ^
      const DeepCollectionEquality().hash(nextClaimTimestamp) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$RewardClaimCopyWith<_RewardClaim> get copyWith =>
      __$RewardClaimCopyWithImpl<_RewardClaim>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RewardClaimToJson(this);
  }
}

abstract class _RewardClaim implements RewardClaim {
  factory _RewardClaim(
      {required String amount,
      required double humanAmount,
      required bool isClaimed,
      required String walletAddress,
      required String tokenAddress,
      required int syncTimestamp,
      required int syncBlockNumber,
      required int nextClaimTimestamp,
      required DateTime createdAt,
      required DateTime updatedAt,
      @JsonKey(name: '_id') required String id}) = _$_RewardClaim;

  factory _RewardClaim.fromJson(Map<String, dynamic> json) =
      _$_RewardClaim.fromJson;

  @override
  String get amount => throw _privateConstructorUsedError;
  @override
  double get humanAmount => throw _privateConstructorUsedError;
  @override
  bool get isClaimed => throw _privateConstructorUsedError;
  @override
  String get walletAddress => throw _privateConstructorUsedError;
  @override
  String get tokenAddress => throw _privateConstructorUsedError;
  @override
  int get syncTimestamp => throw _privateConstructorUsedError;
  @override
  int get syncBlockNumber => throw _privateConstructorUsedError;
  @override
  int get nextClaimTimestamp => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RewardClaimCopyWith<_RewardClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

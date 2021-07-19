// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RewardClaim _$_$_RewardClaimFromJson(Map<String, dynamic> json) {
  return _$_RewardClaim(
    amount: json['amount'] as String,
    humanAmount: (json['humanAmount'] as num).toDouble(),
    isClaimed: json['isClaimed'] as bool,
    walletAddress: json['walletAddress'] as String,
    tokenAddress: json['tokenAddress'] as String,
    syncTimestamp: json['syncTimestamp'] as int,
    syncBlockNumber: json['syncBlockNumber'] as int,
    nextClaimTimestamp: json['nextClaimTimestamp'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$_$_RewardClaimToJson(_$_RewardClaim instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'humanAmount': instance.humanAmount,
      'isClaimed': instance.isClaimed,
      'walletAddress': instance.walletAddress,
      'tokenAddress': instance.tokenAddress,
      'syncTimestamp': instance.syncTimestamp,
      'syncBlockNumber': instance.syncBlockNumber,
      'nextClaimTimestamp': instance.nextClaimTimestamp,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '_id': instance.id,
    };

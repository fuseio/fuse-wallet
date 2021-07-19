import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_claim.freezed.dart';
part 'reward_claim.g.dart';

@immutable
@freezed
class RewardClaim with _$RewardClaim {
  @JsonSerializable()
  factory RewardClaim({
    required String amount,
    required double humanAmount,
    required bool isClaimed,
    required String walletAddress,
    required String tokenAddress,
    required int syncTimestamp,
    required int syncBlockNumber,
    required int nextClaimTimestamp,
    required DateTime createdAt,
    required DateTime updatedAt,
    @JsonKey(name: '_id') required String id,
  }) = _RewardClaim;

  factory RewardClaim.fromJson(Map<String, dynamic> json) =>
      _$RewardClaimFromJson(json);
}

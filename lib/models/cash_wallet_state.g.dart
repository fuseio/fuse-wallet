// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return CashWalletState(
    communityAddress: json['communityAddress'] as String,
    communities: CashWalletState._communitiesFromJson(
        json['communities'] as Map<String, dynamic>),
    nextReward: CashWalletState._rewardFromJson(json['nextReward'] as String),
    currentReward:
        CashWalletState._rewardFromJson(json['currentReward'] as String),
  );
}

Map<String, dynamic> _$CashWalletStateToJson(CashWalletState instance) =>
    <String, dynamic>{
      'nextReward': instance.nextReward?.toString(),
      'currentReward': instance.currentReward?.toString(),
      'communityAddress': instance.communityAddress,
      'communities': CashWalletState._communitiesToJson(instance.communities),
    };

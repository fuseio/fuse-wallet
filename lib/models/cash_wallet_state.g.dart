// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return CashWalletState(
    walletAddress: json['walletAddress'] as String,
    walletStatus: json['walletStatus'] as String,
    communityAddress: json['communityAddress'] as String,
    communityName: json['communityName'] as String,
    communities: CashWalletState._communitiesFromJson(
        json['communities'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CashWalletStateToJson(CashWalletState instance) =>
    <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'communityAddress': instance.communityAddress,
      'communityName': instance.communityName,
      'communities': CashWalletState._communitiesToJson(instance.communities),
    };

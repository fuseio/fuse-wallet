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
    isCommunityLoading: json['isCommunityLoading'] as bool,
    communities: (json['communities'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Community.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$CashWalletStateToJson(CashWalletState instance) =>
    <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'communityAddress': instance.communityAddress,
      'communityName': instance.communityName,
      'communities':
          instance.communities?.map((k, e) => MapEntry(k, e?.toJson())),
      'isCommunityLoading': instance.isCommunityLoading,
    };

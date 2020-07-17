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
  );
}

Map<String, dynamic> _$CashWalletStateToJson(CashWalletState instance) =>
    <String, dynamic>{
      'communityAddress': instance.communityAddress,
      'communities': CashWalletState._communitiesToJson(instance.communities),
    };

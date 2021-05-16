// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CashWalletState _$_$_CashWalletStateFromJson(Map<String, dynamic> json) {
  return _$_CashWalletState(
    communityAddress: json['communityAddress'] as String,
    isDepositBanner: json['isDepositBanner'] as bool? ?? true,
    tokens: tokensFromJson(json['tokens'] as Map<String, dynamic>),
    communities:
        communitiesFromJson(json['communities'] as Map<String, dynamic>),
    walletActions:
        walletActionsFromJson(json['walletActions'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CashWalletStateToJson(_$_CashWalletState instance) =>
    <String, dynamic>{
      'communityAddress': instance.communityAddress,
      'isDepositBanner': instance.isDepositBanner,
      'tokens': instance.tokens.map((k, e) => MapEntry(k, e.toJson())),
      'communities':
          instance.communities.map((k, e) => MapEntry(k, e.toJson())),
      'walletActions': instance.walletActions?.toJson(),
    };

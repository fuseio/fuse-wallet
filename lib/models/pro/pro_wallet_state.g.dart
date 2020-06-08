// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return ProWalletState(
    blockNumber: json['blockNumber'] as num,
    etherBalance:
        ProWalletState._etherBalanceFromJson(json['etherBalance'] as String),
    erc20Tokens: ProWalletState._erc20TokensFromJson(
        json['erc20Tokens'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProWalletStateToJson(ProWalletState instance) =>
    <String, dynamic>{
      'etherBalance': instance.etherBalance?.toString(),
      'blockNumber': instance.blockNumber,
      'erc20Tokens':
          instance.erc20Tokens?.map((k, e) => MapEntry(k, e?.toJson())),
    };

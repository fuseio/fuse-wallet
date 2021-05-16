// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProWalletState _$_$_ProWalletStateFromJson(Map<String, dynamic> json) {
  return _$_ProWalletState(
    etherBalance: balanceFromJson(json['etherBalance'] as String?),
    erc20Tokens:
        erc20TokensFromJson(json['erc20Tokens'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_ProWalletStateToJson(_$_ProWalletState instance) =>
    <String, dynamic>{
      'etherBalance': instance.etherBalance.toString(),
      'erc20Tokens':
          instance.erc20Tokens?.map((k, e) => MapEntry(k, e.toJson())),
    };

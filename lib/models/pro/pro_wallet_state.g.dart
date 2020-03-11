// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return ProWalletState(
    walletAddress: json['walletAddress'] as String,
    walletStatus: json['walletStatus'] as String,
    transactions: json['transactions'] == null
        ? null
        : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProWalletStateToJson(ProWalletState instance) =>
    <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'transactions': instance.transactions?.toJson(),
    };

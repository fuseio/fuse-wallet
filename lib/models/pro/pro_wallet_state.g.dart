// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return ProWalletState(
    transactions: json['transactions'] == null
        ? null
        : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProWalletStateToJson(ProWalletState instance) =>
    <String, dynamic>{
      'transactions': instance.transactions?.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transactions _$TransactionsFromJson(Map<String, dynamic> json) {
  return Transactions(
    list: Transactions._listFromJson(json['list'] as Map<String, dynamic>),
    blockNumber: json['blockNumber'] as num,
  );
}

Map<String, dynamic> _$TransactionsToJson(Transactions instance) =>
    <String, dynamic>{
      'list': Transactions._listToJson(instance.list),
      'blockNumber': instance.blockNumber,
    };

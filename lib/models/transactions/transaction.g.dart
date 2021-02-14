// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    txHash: json['txHash'] as String,
    type: json['type'] as String,
    isSwap: json['isSwap'] as bool,
    status: json['status'] as String,
    text: json['text'] as String,
    blockNumber: json['blockNumber'] as int,
    timestamp: json['timestamp'] as int,
    jobId: json['jobId'] as String,
    failReason: json['failReason'] as String,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    actionType: json['actionType'] as String,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'tokenAddress': instance.tokenAddress,
      'txHash': instance.txHash,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'status': instance.status,
      'text': instance.text,
      'blockNumber': instance.blockNumber,
      'jobId': instance.jobId,
      'to': instance.to,
      'from': instance.from,
      'value': instance.value?.toString(),
      'isSwap': instance.isSwap,
      'failReason': instance.failReason,
      'actionType': instance.actionType,
    };

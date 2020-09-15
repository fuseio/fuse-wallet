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
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'txHash': instance.txHash,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'status': instance.status,
      'text': instance.text,
      'blockNumber': instance.blockNumber,
      'jobId': instance.jobId,
      'isSwap': instance.isSwap,
      'failReason': instance.failReason,
    };

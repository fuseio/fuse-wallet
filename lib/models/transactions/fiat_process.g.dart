// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiat_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiatProcess _$FiatProcessFromJson(Map<String, dynamic> json) {
  return FiatProcess(
    txHash: json['txHash'] as String,
    type: json['type'] as String,
    status: json['status'] as String,
    text: json['text'] as String,
    jobId: json['jobId'] as String,
    blockNumber: json['blockNumber'] as int,
    failReason: json['failReason'] as String,
    timestamp: json['timestamp'] as int,
    isSwap: json['isSwap'] as bool,
    to: json['to'] as String,
    from: json['from'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    tokenAddress: json['tokenAddress'] as String,
    actionType: json['actionType'] as String,
  );
}

Map<String, dynamic> _$FiatProcessToJson(FiatProcess instance) =>
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

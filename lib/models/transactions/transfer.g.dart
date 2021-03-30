// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return Transfer(
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
    receiverName: json['receiverName'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'txHash': instance.txHash,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'status': instance.status,
      'text': instance.text,
      'blockNumber': instance.blockNumber,
      'jobId': instance.jobId,
      'isSwap': instance.isSwap,
      'failReason': instance.failReason,
      'to': instance.to,
      'from': instance.from,
      'value': instance.value?.toString(),
      'tokenAddress': instance.tokenAddress,
      'receiverName': instance.receiverName,
      'note': instance.note,
    };

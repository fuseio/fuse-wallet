// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return Transfer(
    to: json['to'] as String,
    from: json['from'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    txHash: json['txHash'] as String,
    tokenAddress: json['tokenAddress'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
      'value': instance.value?.toString(),
      'tokenAddress': instance.tokenAddress,
      'txHash': instance.txHash,
      'type': instance.type,
    };

PendingTransfer _$PendingTransferFromJson(Map<String, dynamic> json) {
  return PendingTransfer(
    to: json['to'] as String,
    from: json['from'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    txHash: json['txHash'] as String,
    tokenAddress: json['tokenAddress'] as String,
    type: json['type'] as String,
    jobId: json['jobId'] as String,
  );
}

Map<String, dynamic> _$PendingTransferToJson(PendingTransfer instance) =>
    <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
      'value': instance.value?.toString(),
      'tokenAddress': instance.tokenAddress,
      'txHash': instance.txHash,
      'type': instance.type,
      'jobId': instance.jobId,
    };

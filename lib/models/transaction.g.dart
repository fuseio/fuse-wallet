// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    txHash: json['txHash'] as String,
    type: json['type'] as String,
    status: json['status'] as String,
    text: json['text'] as String,
    blockNumber: json['blockNumber'] as int,
    jobId: json['jobId'] as String,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'txHash': instance.txHash,
      'type': instance.type,
      'status': instance.status,
      'text': instance.text,
      'blockNumber': instance.blockNumber,
      'jobId': instance.jobId,
    };

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return Transfer(
    txHash: json['txHash'] as String,
    type: json['type'] as String,
    status: json['status'] as String,
    text: json['text'] as String,
    jobId: json['jobId'] as String,
    blockNumber: json['blockNumber'] as int,
    to: json['to'] as String,
    from: json['from'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    tokenAddress: json['tokenAddress'] as String,
    receiverName: json['receiverName'] as String,
  );
}

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'txHash': instance.txHash,
      'type': instance.type,
      'status': instance.status,
      'text': instance.text,
      'blockNumber': instance.blockNumber,
      'jobId': instance.jobId,
      'to': instance.to,
      'from': instance.from,
      'value': instance.value?.toString(),
      'tokenAddress': instance.tokenAddress,
      'receiverName': instance.receiverName,
    };

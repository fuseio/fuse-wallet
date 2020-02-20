// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_wallet_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateWalletJob _$GenerateWalletJobFromJson(Map<String, dynamic> json) {
  return GenerateWalletJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
    timeStart: json['timeStart'],
    isReported: json['isReported'],
  );
}

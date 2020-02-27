// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferJob _$TransferJobFromJson(Map<String, dynamic> json) {
  return TransferJob(
    id: json['id'],
    jobType: json['jobType'],
    name: json['name'],
    status: json['status'],
    data: json['data'],
    arguments: json['arguments'],
    lastFinishedAt: json['lastFinishedAt'],
    timeStart: json['timeStart'],
    isReported: json['isReported'],
    isFunderJob: json['isFunderJob'],
  );
}

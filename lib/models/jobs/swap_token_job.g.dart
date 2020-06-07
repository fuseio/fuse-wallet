// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap_token_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwapTokenJob _$SwapTokenJobFromJson(Map<String, dynamic> json) {
  return SwapTokenJob(
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

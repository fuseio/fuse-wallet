import 'dart:convert';

import 'package:esol/models/jobs/approve_job.dart';
import 'package:esol/models/jobs/backup_job.dart';
import 'package:esol/models/jobs/generate_wallet_job.dart';
import 'package:esol/models/jobs/invite_bonus_job.dart';
import 'package:esol/models/jobs/invite_job.dart';
import 'package:esol/models/jobs/join_bonus_job.dart';
import 'package:esol/models/jobs/join_community_job.dart';
import 'package:esol/models/jobs/swap_token_job.dart';
import 'package:esol/models/jobs/transfer_job.dart';

abstract class Job {
  static const String RELAY = "relay";
  static const String CREATE_WALLET = "createWallet";

  static const String COMMUNITY_MANAGER = "CommunityManager";
  static const String TRANSFER_MANAGER = "TransferManager";
  static const String DAI_POINTS_MANAGER = "DAIPointsManager";

  String status;
  dynamic arguments;
  bool isReported;
  bool isFunderJob;
  String id;
  final String jobType;
  final String name;
  final dynamic data;
  final String lastFinishedAt;
  final int timeStart;

  Job(
      {this.id,
      this.jobType,
      this.name,
      this.status,
      this.arguments,
      this.isFunderJob,
      this.data,
      this.lastFinishedAt,
      this.timeStart,
      this.isReported}) {
    this.arguments = argumentsFromJson(arguments);
  }

  Future<dynamic> fetch();
  Future<dynamic> onDone(store, dynamic fetchedData);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'jobType': this.jobType,
        'name': this.name,
        'status': this.status,
        'data': this.data,
        'isReported': this.isReported,
        'timeStart': this.timeStart,
        'lastFinishedAt': this.lastFinishedAt,
        'isFunderJob': this.isFunderJob,
        'arguments': argumentsToJson()
      };

  Future perform(dynamic store, Function isJobProcessValid) async {
    dynamic fetchedData = await fetch();
    if (isJobProcessValid()) {
      onDone(store, fetchedData);
    }
  }

  dynamic argumentsToJson() {
    return jsonEncode(arguments);
  }

  Map<String, dynamic> argumentsFromJson(arguments) {
    return arguments;
  }
}

class JobFactory {
  static String getJobType(Map<String, dynamic> job) {
    if (job.containsKey('jobType')) {
      return job['jobType'];
    }
    if (job['name'] == Job.RELAY) {
      if (job['data']['walletModule'] == Job.COMMUNITY_MANAGER) {
        return 'joinCommunity';
      } else if (job['data']['walletModule'] == Job.TRANSFER_MANAGER &&
          (job['data']['methodName'] != null &&
              job['data']['methodName'] == 'approveToken')) {
        return 'approveToken';
      } else if (job['data']['walletModule'] == Job.TRANSFER_MANAGER) {
        return 'transfer';
      } else if (job['data']['walletModule'] == Job.DAI_POINTS_MANAGER) {
        return 'transfer';
      }
    }
    if (job['name'] == Job.CREATE_WALLET) {
      if (job['data'].containsKey('phoneNumber')) {
        return 'invite';
      } else {
        return Job.CREATE_WALLET;
      }
    }
    return job['name'];
  }

  static Job create(Map json) {
    String jobType = JobFactory.getJobType(json);
    String id = json.containsKey('_id') ? json['_id'] : json['id'];
    String status = json.containsKey('status') ? json['status'] : 'PENDING';
    switch (jobType) {
      case 'setWalletOwner':
        return new GenerateWalletJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'createWallet':
        return new GenerateWalletJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'joinCommunity':
        return new JoinCommunityJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'transfer':
        return new TransferJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'invite':
        return new InviteJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'backup':
        return new BackupJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'inviteBonus':
        return new InviteBonusJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'joinBonus':
        return new JoinBonusJob(
            id: id,
            isFunderJob: json['isFunderJob'],
            jobType: jobType,
            name: jobType,
            status: status,
            data: json['data'],
            arguments: json['arguments']);
      case 'approveToken':
        return new ApproveJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
      case 'swapToken':
        return new SwapTokenJob(
            id: id,
            jobType: jobType,
            name: json['name'],
            status: status,
            data: json['data'],
            lastFinishedAt: json['lastFinishedAt'],
            arguments: json['arguments']);
    }
    print('ERROR: $jobType not supported');
    return null;
  }
}

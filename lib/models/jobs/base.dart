import 'dart:convert';

import 'package:fusecash/models/jobs/generate_wallet_job.dart';
import 'package:fusecash/models/jobs/invite_job.dart';
import 'package:fusecash/models/jobs/join_community_job.dart';
import 'package:fusecash/models/jobs/transfer_job.dart';

abstract class Job {
  static const String RELAY = "relay";
  static const String CREATE_WALLET = "createWallet";

  static const String COMMUNITY_MANAGER = "CommunityManager";
  static const String TRANSFER_MANAGER = "TransferManager";

  String status;
  Map<String, dynamic> arguments;
  final String id;
  final String jobType;
  final String name;
  final dynamic data;
  final String lastFinishedAt;

  Job(
      {this.id,
      this.jobType,
      this.name,
      status,
      arguments,
      this.data,
      this.lastFinishedAt}) {
    this.arguments = argumentsFromJson(arguments);
  }

  Future<dynamic> fetch();
  Future<dynamic> onDone(store, dynamic fetchedData);
  Map<String, dynamic> toJson() => {};

  Future perform(dynamic store, Function isJobProcessValid) async {
    dynamic fetchedData = await fetch();
    if (isJobProcessValid()) {
      onDone(store, fetchedData);
    }
  }

  dynamic argumentsToJson() {
    return jsonEncode(arguments);
  }

  dynamic argumentsFromJson(arguments) {
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
      } else if (job['data']['walletModule'] == Job.TRANSFER_MANAGER) {
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
    }
    print('ERROR: $jobType not supported');
    return null;
  }
}


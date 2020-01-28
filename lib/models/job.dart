
import 'package:fusecash/services.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'dart:convert'; 

String getJobType(Map<String, dynamic> job) {
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
  return job['name'];
}
abstract class Job {
  static const String RELAY = "relay";
  static const String CREATE_WALLET = "createWallet";

  static const String COMMUNITY_MANAGER = "CommunityManager";
  static const String TRANSFER_MANAGER = "TransferManager";

  final String id;
  final String jobType;
  final String name;
  String status;
  final dynamic data;
  final dynamic arguments;
  final String lastFinishedAt;

  Job({
    this.id,
    this.jobType,
    this.name,
    this.status,
    this.data,
    this.arguments,
    this.lastFinishedAt
  });

  Future perform(dynamic store);

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'jobType': this.jobType,
    'name': this.name,
    'status': this.status,
    'data': this.data,
    'lastFinishedAt': this.lastFinishedAt,
    'arguments': argumentsToJson()
  };

  dynamic argumentsToJson() {
    return json.encode(arguments);
  }
}

class GenerateWalletJob extends Job {
  GenerateWalletJob({
    id,
    jobType,
    name,
    status,
    data,
    arguments,
    lastFinishedAt
  }) : super(
    id: id,
    jobType: jobType,
    name: name,
    status: status,
    data: data,
    arguments: arguments,
    lastFinishedAt: lastFinishedAt
  );

   Future perform(store) async {
      dynamic wallet = await api.getWallet();
      String walletAddress = wallet["walletAddress"];
      if (walletAddress != null && walletAddress.isNotEmpty) {
        status = 'DONE';
      }
      store.dispatch(generateWalletSuccessCall(wallet, arguments['accountAddress']));
    }
}

class JoinCommunityJob extends Job {
  JoinCommunityJob({
    id,
    jobType,
    name,
    status,
    data,
    arguments,
    lastFinishedAt
  }) : super(
    id: id,
    jobType: jobType,
    name: name,
    status: status,
    data: data,
    arguments: arguments,
    lastFinishedAt: lastFinishedAt
  );

   Future perform(store) async {
      dynamic response = await api.getJob(this.id);
      Job job = JobFactory.create(response);

      if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
        logger.wtf('job not done');
        return;
      }
      status = 'DONE';
      store.dispatch(joinCommunitySuccessCall(job, arguments['transfer'], arguments['community']));
    }


  dynamic argumentsToJson() {
    return {
      'transfer': arguments['transfer'].toJson(),
      'community': arguments['community']
    };
  }
}

class TransferJob extends Job {
  TransferJob({
    id,
    jobType,
    name,
    status,
    data,
    arguments,
    lastFinishedAt
  }) : super(
    id: id,
    jobType: jobType,
    name: name,
    status: status,
    data: data,
    arguments: arguments,
    lastFinishedAt: lastFinishedAt
  );

   Future perform(store) async {
      dynamic response = await api.getJob(this.id);
      Job job = JobFactory.create(response);

      if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
        logger.wtf('job not done');
        return;
      }
      status = 'DONE';
      store.dispatch(sendTokenSuccessCall(job, arguments['transfer']));
    }


  dynamic argumentsToJson() {
    return {
      'transfer': arguments['transfer'].toJson()
    };
  }
}

class JobFactory {
  static Job create(dynamic json) {
    String jobType = getJobType(json);
    switch (jobType) {
      case 'createWallet':
        return new GenerateWalletJob(
          id: json['_id'],
          jobType: jobType,
          name: json['name'],
          status: json.containsKey('status') ? json['status'] : 'PENDING',
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
      case 'joinCommunity':
        return new JoinCommunityJob(
          id: json['_id'],
          jobType: jobType,
          name: json['name'],
          status: json.containsKey('status') ? json['status'] : 'PENDING',
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
      case 'transfer':
        return new TransferJob(
          id: json['_id'],
          jobType: jobType,
          name: json['name'],
          status: json.containsKey('status') ? json['status'] : 'PENDING',
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
    }
    return null;
  }
}




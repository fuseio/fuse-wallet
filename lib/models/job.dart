
import 'package:fusecash/services.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import './transaction.dart';
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
  dynamic arguments;
  final String lastFinishedAt;

  Job({
    this.id,
    this.jobType,
    this.name,
    this.status,
    this.data,
    arguments,
    this.lastFinishedAt
  }) {
    this.arguments = argumentsFromJson(arguments);
  }

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

  dynamic argumentsFromJson(arguments) {
    return arguments;
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

  dynamic argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('transfer')) {
      if (arguments['transfer']  is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic> .from(arguments);
        nArgs['transfer'] = TransactionFactory.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
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

  dynamic argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('transfer')) {
      if (arguments['transfer']  is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic> .from(arguments);
        nArgs['transfer'] = TransactionFactory.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
  }
}

class JobFactory {
  static Job create(Map json) {
    String jobType = getJobType(json);
    String id = json.containsKey('_id') ? json['_id'] : json['id'];
    String status = json.containsKey('status') ? json['status'] : 'PENDING';
    switch (jobType) {
      case 'createWallet':
        return new GenerateWalletJob(
          id: id,
          jobType: jobType,
          name: json['name'],
          status: status,
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
      case 'joinCommunity':
        return new JoinCommunityJob(
          id: id,
          jobType: jobType,
          name: json['name'],
          status: status,
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
      case 'transfer':
        return new TransferJob(
          id: id,
          jobType: jobType,
          name: json['name'],
          status: status,
          data: json['data'],
          lastFinishedAt: json['lastFinishedAt'],
          arguments: json['arguments']
        );
    }
    return null;
  }
}




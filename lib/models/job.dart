
import 'package:fusecash/services.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class Job {
  static const String RELAY = "relay";
  static const String CREATE_WALLET = "createWallet";

  static const String COMMUNITY_MANAGER = "CommunityManager";
  static const String TRANSFER_MANAGER = "TransferManager";

  final String id;
  final String name;
  String status;
  final dynamic data;
  final dynamic arguments;
  final String lastFinishedAt;

  Job({
    this.id,
    this.name,
    this.status,
    this.data,
    this.arguments,
    this.lastFinishedAt
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'],
    name: json['name'],
    status: json.containsKey('status') ? json['status'] : 'PENDING',
    data: json['data'],
    lastFinishedAt: json['lastFinishedAt'],
  );

  Future perform(dynamic store) async {
    
  }
}

class GenerateWalletJob extends Job {
  GenerateWalletJob({
    id,
    name,
    status,
    data,
    arguments,
    lastFinishedAt
  }) : super(
    id: id,
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
    name,
    status,
    data,
    arguments,
    lastFinishedAt
  }) : super(
    id: id,
    name: name,
    status: status,
    data: data,
    arguments: arguments,
    lastFinishedAt: lastFinishedAt
  );

   Future perform(store) async {
      dynamic response = await api.getJob(this.id);
      Job job = Job.fromJson(response);

      if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
        logger.wtf('job not done');
        return;
      }
      status = 'DONE';
      store.dispatch(joinCommunitySuccessCall(job, arguments['transfer'], arguments['community']));
    }
}

class JobFactory {
  static Job create(dynamic json, dynamic arguments) {
    if (json['name'] == 'createWallet') {
      return new GenerateWalletJob(
        id: json['_id'],
        name: json['name'],
        status: json.containsKey('status') ? json['status'] : 'PENDING',
        data: json['data'],
        lastFinishedAt: json['lastFinishedAt'],
        arguments: arguments
      );
    } else if (json['name'] == 'relay') {
      return new JoinCommunityJob(
        id: json['_id'],
        name: json['name'],
        status: json.containsKey('status') ? json['status'] : 'PENDING',
        data: json['data'],
        lastFinishedAt: json['lastFinishedAt'],
        arguments: arguments
      );
    }
    return null;
  }
}




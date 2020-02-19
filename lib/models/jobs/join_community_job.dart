import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:paywise/redux/state/store.dart';
import 'package:paywise/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_community_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class JoinCommunityJob extends Job {
  JoinCommunityJob({id, jobType, name, status, data, arguments, lastFinishedAt})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            lastFinishedAt: lastFinishedAt);

  @override
  fetch() async {
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    Job job = JobFactory.create(fetchedData);

    if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
      final logger = await AppFactory().getLogger('job');
      logger.info('JoinCommunityJob not done');
      return;
    }
    status = 'DONE';
    store.dispatch(joinCommunitySuccessCall(
        job, arguments['transfer'], arguments['community']));
  }

  @override
  dynamic argumentsToJson() => {
      'transfer': arguments['transfer'].toJson(),
      'community': arguments['community']
    };

  @override
  dynamic argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('transfer')) {
      if (arguments['transfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['transfer'] = TransactionFactory.fromJson(arguments['transfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static JoinCommunityJob fromJson(dynamic json) => _$JoinCommunityJobFromJson(json);
}
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class InviteJob extends Job {
  InviteJob({id, jobType, name, status, data, arguments, lastFinishedAt})
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
      final logger = await AppFactory().getLogger('Job');
      logger.info('InviteJob job not done');
      return;
    }
    status = 'DONE';
    store.dispatch(inviteAndSendSuccessCall(
        job,
        arguments['tokensAmount'],
        arguments['receiverName'],
        arguments['inviteTransfer'],
        arguments['sendSuccessCallback'],
        arguments['sendFailureCallback']));
  }

  @override
  dynamic argumentsToJson() => {
      'tokensAmount': arguments['tokensAmount'],
      'receiverName': arguments['receiverName'],
      'inviteTransfer': arguments['inviteTransfer'].toJson()
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('inviteTransfer')) {
      if (arguments['inviteTransfer'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['inviteTransfer'] = TransactionFactory.fromJson(arguments['inviteTransfer']);
        return nArgs;
      }
    }
    return arguments;
  }

  static InviteJob fromJson(dynamic json) => _$InviteJobFromJson(json);
}
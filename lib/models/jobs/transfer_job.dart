import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class TransferJob extends Job {
  TransferJob({id, jobType, name, status, data, arguments, lastFinishedAt})
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
      logger.info('TransferJob not done');
      return;
    }
    status = 'DONE';
    store.dispatch(sendTokenSuccessCall(job, arguments['transfer']));
  }

  @override
  dynamic argumentsToJson() => {
    'transfer': arguments['transfer'].toJson()
  };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
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

  static TransferJob fromJson(dynamic json) => _$TransferJobFromJson(json);
}
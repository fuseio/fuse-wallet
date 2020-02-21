import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class TransferJob extends Job {
  TransferJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            lastFinishedAt: lastFinishedAt,
            isReported: isReported ?? false,
            timeStart: timeStart ?? new DateTime.now().millisecondsSinceEpoch);

  @override
  fetch() async {
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    Job job = JobFactory.create(fetchedData);
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job $id $name'));
      isReported = true;
    }

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
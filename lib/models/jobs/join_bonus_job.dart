import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:paywise/redux/state/store.dart';
import 'package:paywise/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_bonus_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class JoinBonusJob extends Job {
  JoinBonusJob({id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported, isFunderJob})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            lastFinishedAt: lastFinishedAt,
            isReported: isReported,
            timeStart: timeStart ?? DateTime.now().millisecondsSinceEpoch,
            isFunderJob: isFunderJob ?? true);

  @override
  fetch() async {
    if (this.isFunderJob == true) {
      return api.getFunderJob(this.id);
    }
    return api.getJob(this.id);
  }

  @override
  onDone(store, dynamic fetchedData) async {
    final logger = await AppFactory().getLogger('Job');
    if (isReported == true) {
      this.status = 'FAILED';
      logger.info('joinBonus FAILED');
      store.dispatch(transactionFailed(arguments['joinBonus']));
      store.dispatch(segmentTrackCall('Wallet: joinBonus FAILED'));
      return;
    }
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && isReported != null && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job $id $name'));
      this.isReported = true;
    }

    dynamic data = fetchedData['data'];
    String responseStatus = data['status'];
    if (responseStatus == 'SUCCEEDED') {
      this.status = 'DONE';
      store.dispatch(joinBonusSuccessCall(data['txHash'], arguments['joinBonus']));
      store.dispatch(segmentTrackCall('Wallet: SUCCEEDED job $id $name'));
      logger.info('JoinBonusJob SUCCEEDED');
      return;
    } else if (responseStatus == 'FAILED') {
      this.status = 'FAILED';
      logger.info('JoinBonusJob FAILED');
      store.dispatch(transactionFailed(arguments['joinBonus']));
    }
  }

  @override
  dynamic argumentsToJson() => {
      'joinBonus': arguments['joinBonus'].toJson(),
      'jobType': arguments['jobType']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('joinBonus')) {
      if (arguments['joinBonus'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['joinBonus'] = TransactionFactory.fromJson(arguments['joinBonus']);
        return nArgs;
      }
    }
    return arguments;
  }

  static JoinBonusJob fromJson(dynamic json) => _$JoinBonusJobFromJson(json);
}
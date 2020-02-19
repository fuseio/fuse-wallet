import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/redux/actions/user_actions.dart';
import 'package:paywise/redux/state/store.dart';
import 'package:paywise/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backup_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class BackupJob extends Job {
  BackupJob({id, jobType, name, status, data, arguments, lastFinishedAt})
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
    if (fetchedData['data']['funderJobId'] != null) {
      dynamic response = await api.getFunderJob(fetchedData['data']['funderJobId']);
      dynamic data = response['data'];
      if (data['status'] == 'SUCCEEDED') {
        status = 'DONE';
        store.dispatch(backupSuccessCall(data['txHash'], arguments['backupBonus']));
        return;
      }
      final logger = await AppFactory().getLogger('Job');
      logger.info('BackupJob job not done');
    }
  }

  @override
  dynamic argumentsToJson() => {
      'backupBonus': arguments['backupBonus'],
      'jobType': arguments['jobType']
    };

  @override
  Map<String, dynamic> argumentsFromJson(arguments) {
    if (arguments == null) {
      return arguments;
    }
    if (arguments.containsKey('backupBonus')) {
      if (arguments['backupBonus'] is Map) {
        Map<String, dynamic> nArgs = Map<String, dynamic>.from(arguments);
        nArgs['backupBonus'] = TransactionFactory.fromJson(arguments['backupBonus']);
        return nArgs;
      }
    }
    return arguments;
  }

  static BackupJob fromJson(dynamic json) => _$BackupJobFromJson(json);
}
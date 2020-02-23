import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate_wallet_job.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class GenerateWalletJob extends Job {
  GenerateWalletJob(
      {id, jobType, name, status, data, arguments, lastFinishedAt, timeStart, isReported})
      : super(
            id: id,
            jobType: jobType,
            name: name,
            status: status,
            data: data,
            arguments: arguments,
            isReported: isReported ?? false,
            lastFinishedAt: lastFinishedAt,
            timeStart: timeStart ?? new DateTime.now().millisecondsSinceEpoch);

  @override
  fetch() async {
    return api.getWallet();
  }

  @override
  onDone(store, dynamic fetchedData) async {
    int current = DateTime.now().millisecondsSinceEpoch;
    int jobTime = this.timeStart;
    final int millisecondsIntoMin = 2 * 60 * 1000;
    if ((current - jobTime) > millisecondsIntoMin && !isReported) {
      store.dispatch(segmentTrackCall('Wallet: pending job $id $name'));
      isReported = true;
    }

    String walletAddress = fetchedData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      status = 'DONE';
    }
    store.dispatch(generateWalletSuccessCall(fetchedData, arguments['accountAddress']));
    store.dispatch(segmentTrackCall('Wallet: SUCCEEDED job $id $name'));
  }

  static GenerateWalletJob fromJson(dynamic json) => _$GenerateWalletJobFromJson(json);
}

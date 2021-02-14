import 'package:fusecash/models/transactions/fiat_deposit.dart';
import 'package:fusecash/models/transactions/fiat_process.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';

class TransactionFactory {
  static Transaction fromJson(Map<String, dynamic> json) {
    if (json['actionType'] != null) {
      if (json['actionType'] == 'fiat-processing') {
        return FiatProcess.fromJson(json);
      } else if (json['actionType'] == 'fiat-deposit') {
        return FiatDeposit.fromJson(json);
      }
    } else if (json['type'] == 'RECEIVE' || json['type'] == 'SEND') {
      return Transfer.fromJson(json);
    }
    return Transaction.fromJson(json);
  }
}

import 'package:equatable/equatable.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class ProWalletViewModel extends Equatable {
  final String walletAddress;
  final String displayName;
  final bool isTransfersFetchingStarted;
  final Transactions transactions;
  final Function() startTransfersFetching;
  final bool isJobProcessingStarted;

  ProWalletViewModel({
    this.walletAddress,
    this.isTransfersFetchingStarted,
    this.displayName,
    this.transactions,
    this.startTransfersFetching,
    this.isJobProcessingStarted,
  });

  static ProWalletViewModel fromStore(Store<AppState> store) {
    return ProWalletViewModel(
      walletAddress: store.state.userState.walletAddress,
      transactions: store.state.proWalletState.transactions,
      startTransfersFetching: () {
        store.dispatch(startTransfersFetchingCall());
      },
    );
  }

  @override
  List<Object> get props => [
    walletAddress,
    displayName,
    transactions,
    isTransfersFetchingStarted
  ];
}
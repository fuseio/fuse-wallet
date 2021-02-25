import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class FeedViewModel extends Equatable {
  final List<WalletAction> walletActions;
  final Function() startFetching;
  final Function() refreshFeed;

  FeedViewModel({
    this.startFetching,
    this.refreshFeed,
    this.walletActions,
  });

  static FeedViewModel fromStore(Store<AppState> store) {
    return FeedViewModel(
      walletActions: List.from(
              store.state.cashWalletState?.walletActions?.list?.reversed) ??
          [],
      startFetching: () {
        store.dispatch(startFetchingCall());
        store.dispatch(startFetchTokensBalances());
      },
      refreshFeed: () {
        store.dispatch(fetchListOfTokensByAddress());
        store.dispatch(ResetTokenTxs());
      },
    );
  }

  @override
  List<Object> get props => [
        walletActions,
      ];
}

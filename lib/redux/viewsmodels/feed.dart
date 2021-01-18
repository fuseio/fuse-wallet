import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class FeedViewModel extends Equatable {
  final List<Transaction> feedList;
  final String walletStatus;
  final Function() startTransfersFetching;
  final Function() startProcessingJobs;
  final Function() refreshFeed;
  final List<Community> communities;

  FeedViewModel({
    this.feedList,
    this.walletStatus,
    this.startTransfersFetching,
    this.startProcessingJobs,
    this.refreshFeed,
    this.communities,
  });

  static FeedViewModel fromStore(Store<AppState> store) {
    List<Transaction> tokensTxs =
        store.state.cashWalletState.tokens?.values?.fold(
      [],
      (List<Transaction> previousValue, Token token) => previousValue
        ..addAll(
          token?.transactions?.list ?? [],
        ),
    );

    List<Transaction> erc20TokensTxs =
        store.state.proWalletState.erc20Tokens?.values?.fold(
      [],
      (List<Transaction> previousValue, Token token) => previousValue
        ..addAll(
          token?.transactions?.list ?? [],
        ),
    );
    List<Transaction> feedList = [...tokensTxs, ...erc20TokensTxs]
      ..sort((a, b) => (b?.timestamp ?? 0).compareTo((a?.timestamp ?? 0)));
    return FeedViewModel(
        feedList: feedList,
        walletStatus: store.state.userState.walletStatus,
        communities: store.state.cashWalletState.communities.values.toList(),
        startTransfersFetching: () {
          store.dispatch(startTransfersFetchingCall());
        },
        startProcessingJobs: () {
          store.dispatch(startProcessingJobsCall());
        },
        refreshFeed: () {
          store.dispatch(fetchListOfTokensByAddress());
          store.dispatch(ResetTokenTxs());
        });
  }

  @override
  List<Object> get props => [feedList, communities, walletStatus];
}

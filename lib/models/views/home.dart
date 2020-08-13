import 'package:equatable/equatable.dart';
import 'package:curadai/models/community/community.dart';
import 'package:curadai/models/tokens/token.dart';
import 'package:curadai/models/transactions/transaction.dart';
import 'package:curadai/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:curadai/models/app_state.dart';
import 'package:curadai/redux/actions/cash_wallet_actions.dart';

class HomeViewModel extends Equatable {
  final List<Token> tokens;
  final List<Transaction> feedList;
  final Map<String, Community> communities;
  final String accountAddress;
  final String walletAddress;
  final String communityAddress;
  final String branchAddress;
  final String isoCode;
  final bool isCommunityLoading;
  final bool isCommunityFetched;
  final bool isBalanceFetchingStarted;
  final bool isBranchDataReceived;
  final String walletStatus;
  final Function() startTransfersFetching;
  final Function() startProcessingJobs;

  HomeViewModel({
    this.accountAddress,
    this.walletAddress,
    this.walletStatus,
    this.communityAddress,
    this.branchAddress,
    this.isoCode,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isBranchDataReceived,
    this.startTransfersFetching,
    this.startProcessingJobs,
    this.feedList,
    this.tokens,
    this.communities,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();

    List<Token> erc20Tokens = List<Token>.from(
            store.state.proWalletState?.erc20Tokens?.values ?? Iterable.empty())
        .toList();
    List<Token> homeTokens = communities
        .map((Community community) => community?.token
            ?.copyWith(imageUrl: community.metadata.getImageUri()))
        .toList();
    List<Token> tokens = [...homeTokens, ...erc20Tokens]
        .where((Token token) =>
            num.parse(formatValue(token?.amount, token?.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList()
          ..sort((tokenA, tokenB) => (tokenB?.amount ?? BigInt.one)
              ?.compareTo(tokenA?.amount ?? BigInt.zero));

    List<Transaction> erc20TokensTxs =
        store.state.proWalletState.erc20Tokens?.values?.fold(
            [],
            (List<Transaction> previousValue, Token token) =>
                previousValue..addAll(token?.transactions?.list ?? []));
    List<Transaction> communityTxs = communities?.fold(
        [],
        (List<Transaction> previousValue, Community community) =>
            previousValue..addAll(community?.token?.transactions?.list ?? []));
    String communityAddress = store.state.cashWalletState.communityAddress;
    bool isCommunityLoading =
        store.state.cashWalletState.isCommunityLoading ?? false;
    String branchAddress = store.state.cashWalletState.branchAddress;
    List<Transaction> feedList = [...communityTxs, ...erc20TokensTxs]
      ..sort((a, b) => (b?.timestamp ?? 0).compareTo((a?.timestamp ?? 0)));
    return HomeViewModel(
      communities: store.state.cashWalletState.communities,
      tokens: tokens,
      isoCode: store.state.userState.isoCode,
      accountAddress: store.state.userState.accountAddress,
      walletAddress: store.state.userState.walletAddress,
      walletStatus: store.state.userState.walletStatus,
      communityAddress: communityAddress,
      branchAddress: branchAddress,
      isCommunityLoading: isCommunityLoading,
      isCommunityFetched:
          store.state.cashWalletState.isCommunityFetched ?? false,
      isBalanceFetchingStarted:
          store.state.cashWalletState.isBalanceFetchingStarted ?? false,
      isBranchDataReceived:
          store.state.cashWalletState.isBranchDataReceived ?? false,
      feedList: feedList,
      startTransfersFetching: () {
        store.dispatch(startTransfersFetchingCall());
      },
      startProcessingJobs: () {
        store.dispatch(startProcessingJobsCall());
      },
    );
  }

  @override
  List<Object> get props => [
        accountAddress,
        walletAddress,
        walletStatus,
        communityAddress,
        branchAddress,
        isCommunityLoading,
        isBranchDataReceived,
        isoCode,
        feedList,
        isCommunityFetched
      ];
}

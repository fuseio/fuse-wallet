import 'package:equatable/equatable.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/models/tokens/token.dart';
import 'package:seedbed/models/transactions/transaction.dart';
import 'package:seedbed/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';

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
  final Function(bool initial) onReceiveBranchData;
  final Function() refreshFeed;

  HomeViewModel({
    this.onReceiveBranchData,
    this.accountAddress,
    this.walletAddress,
    this.communityAddress,
    this.branchAddress,
    this.isoCode,
    this.isCommunityLoading,
    this.isCommunityFetched,
    this.isBalanceFetchingStarted,
    this.isBranchDataReceived,
    this.feedList,
    this.tokens,
    this.communities,
    this.refreshFeed,
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

    String communityAddress = store.state.cashWalletState.communityAddress;
    bool isCommunityLoading =
        store.state.cashWalletState.isCommunityLoading ?? false;
    String branchAddress = store.state.cashWalletState.branchAddress;

    final bool isBranchDataReceived =
        store.state.cashWalletState.isBranchDataReceived ?? false;
    final bool isCommunityFetched =
        store.state.cashWalletState.isCommunityFetched ?? false;
    final String walletAddress = store.state.userState.walletAddress;
    return HomeViewModel(
        communities: store.state.cashWalletState.communities,
        tokens: tokens,
        isoCode: store.state.userState.isoCode,
        accountAddress: store.state.userState.accountAddress,
        walletAddress: walletAddress,
        communityAddress: communityAddress,
        branchAddress: branchAddress,
        isCommunityLoading: isCommunityLoading,
        isCommunityFetched: isCommunityFetched,
        isBalanceFetchingStarted:
            store.state.cashWalletState.isBalanceFetchingStarted ?? false,
        isBranchDataReceived: isBranchDataReceived,
        onReceiveBranchData: (initial) {
          if (!isCommunityLoading &&
              isCommunityFetched &&
              isBranchDataReceived) {
            store.dispatch(switchCommunityCall(branchAddress));
          } else if (initial) {
            if (!isCommunityLoading &&
                !isBranchDataReceived &&
                !isCommunityFetched &&
                ![null, ''].contains(walletAddress)) {
              store.dispatch(switchCommunityCall(communityAddress));
            }
          }
        },
        refreshFeed: () {
          store.dispatch(ResetTokenTxs());
        });
  }

  @override
  List<Object> get props => [
        accountAddress,
        walletAddress,
        tokens,
        communityAddress,
        branchAddress,
        isCommunityLoading,
        isBranchDataReceived,
        isoCode,
        isCommunityFetched
      ];
}

import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class HomeViewModel extends Equatable {
  final List<Token> tokens;
  final Function(bool initial) onReceiveBranchData;
  final Function() refreshFeed;
  final bool showTabs;

  HomeViewModel({
    this.onReceiveBranchData,
    this.tokens,
    this.refreshFeed,
    this.showTabs,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    List<Token> erc20Tokens = List<Token>.from(
            store.state.proWalletState?.erc20Tokens?.values ?? Iterable.empty())
        .toList();
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .map((Token token) => token?.copyWith(
            imageUrl: store.state.cashWalletState.communities
                    .containsKey(token.communityAddress)
                ? store.state.cashWalletState
                    .communities[token.communityAddress]?.metadata
                    ?.getImageUri()
                : null))
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
    final Map<String, Community> communities =
        store.state.cashWalletState.communities;
    final bool showTabs =
        tokens.any((element) => element.originNetwork == null) ||
            communities.length > 1 ||
            tokens.length > 1;
    return HomeViewModel(
      tokens: tokens,
      showTabs: showTabs,
      onReceiveBranchData: (initial) {
        if (!isCommunityLoading && isCommunityFetched && isBranchDataReceived) {
          store.dispatch(switchCommunityCall(branchAddress));
        } else if (initial) {
          if (store.state.cashWalletState.tokens.isEmpty &&
              !isCommunityLoading &&
              isCommunityFetched &&
              isBranchDataReceived) {
            store.dispatch(switchCommunityCall(communityAddress));
          }
          if (!isCommunityLoading &&
              !isBranchDataReceived &&
              !isCommunityFetched &&
              ![null, ''].contains(walletAddress)) {
            store.dispatch(refetchCommunityData());
          }
        }
      },
      refreshFeed: () {
        store.dispatch(fetchListOfTokensByAddress());
        store.dispatch(ResetTokenTxs());
      },
    );
  }

  @override
  List<Object> get props => [
        showTabs,
        tokens,
      ];
}

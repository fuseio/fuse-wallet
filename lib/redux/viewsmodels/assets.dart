import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
// import 'package:fusecash/utils/addresses.dart' as util;

class TokensListViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final bool showDepositBanner;
  // final List<WalletAction> walletActions;

  TokensListViewModel({
    this.walletAddress,
    this.tokens,
    this.showDepositBanner,
    // this.walletActions,
  });

  static TokensListViewModel fromStore(Store<AppState> store) {
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList();
    final String communityAddress =
        store.state.cashWalletState.communityAddress;
    final Community community =
        store.state.cashWalletState.communities[communityAddress];
    final Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    final WalletAction walletAction =
        store.state.cashWalletState?.walletActions?.list?.firstWhere(
      (element) => element.name == 'createWallet',
      orElse: () => null,
    );
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .map((Token token) => token?.copyWith(
            imageUrl: token.imageUrl != null
                ? token.imageUrl
                : store.state.cashWalletState.communities
                        .containsKey(token.communityAddress)
                    ? store.state.cashWalletState
                        .communities[token.communityAddress]?.metadata
                        ?.getImageUri()
                    : null))
        .toList();
    final List<WalletAction> walletActions =
        List.from(store.state.cashWalletState?.walletActions?.list) ?? [];
    final List<Token> tokens = [...homeTokens, ...foreignTokens]..sort(
        (tokenA, tokenB) => (tokenB?.amount ?? BigInt.zero)
            ?.compareTo(tokenA?.amount ?? BigInt.zero));
    final bool showDepositBanner = token != null &&
        (walletAction != null && walletAction.isConfirmed()) &&
        (walletActions.isNotEmpty && walletActions.length < 2) &&
        tokens != null &&
        tokens.isEmpty;
    return TokensListViewModel(
      // walletActions: walletActions,
      showDepositBanner: showDepositBanner,
      walletAddress: store.state.userState.walletAddress,
      tokens: tokens,
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        tokens,
        // walletActions,
      ];
}

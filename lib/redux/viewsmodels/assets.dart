import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:equatable/equatable.dart';

class TokensListViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final Function() refreshFeed;

  TokensListViewModel({
    this.walletAddress,
    this.tokens,
    this.refreshFeed,
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

    List<Token> homeTokens = List<Token>.from(
            store.state?.cashWalletState?.tokens?.values ?? Iterable.empty())
        .where((Token token) {
          if ([
            Addresses.ZERO_ADDRESS,
            Addresses.FUSE_DOLLAR_TOKEN_ADDRESS,
          ].contains(token.address)) {
            return true;
          } else if (num.parse(formatValue(token?.amount, token?.decimals,
                      withPrecision: true))
                  .compareTo(0) ==
              1) {
            return true;
          }
          return false;
        })
        .map((Token token) => token?.copyWith(
            imageUrl: token.imageUrl != null
                ? token?.imageUrl
                : store.state.cashWalletState.communities
                        .containsKey(token.communityAddress)
                    ? store.state.cashWalletState
                        .communities[token.communityAddress]?.metadata
                        ?.getImageUri()
                    : null))
        .toList();

    final List<Token> tokens = [...homeTokens, ...foreignTokens]..sort(
        (tokenA, tokenB) => num.parse(
          formatValue(
            tokenB?.amount,
            tokenB?.decimals,
            withPrecision: true,
          ),
        )?.compareTo(
          num.parse(
            formatValue(
              tokenA?.amount,
              tokenA?.decimals,
              withPrecision: true,
            ),
          ),
        ),
      );

    return TokensListViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: tokens ?? [],
      refreshFeed: () {
        store.dispatch(refresh());
      },
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        tokens,
      ];
}

import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:equatable/equatable.dart';

class TokensListViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final Function() refreshFeed;

  TokensListViewModel({
    required this.walletAddress,
    required this.tokens,
    required this.refreshFeed,
  });

  static TokensListViewModel fromStore(Store<AppState> store) {
    List<Token> homeTokens =
        List<Token>.from(store.state.cashWalletState.tokens.values)
            .where((Token token) {
              if ([
                Addresses.nativeTokenAddress,
                Addresses.zeroAddress,
              ].contains(token.address)) {
                return true;
              } else if (num.parse(token.getBalance(true)).compareTo(0) == 1) {
                return true;
              }
              return false;
            })
            .map((Token token) => token.copyWith(
                imageUrl: token.imageUrl ??
                    store.state.cashWalletState
                        .communities[token.communityAddress]?.metadata
                        ?.getImageUri() ??
                    ''))
            .toList();

    final List<Token> tokens = [
      ...homeTokens,
    ]..sort();

    return TokensListViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: List<Token>.from(tokens.reversed),
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

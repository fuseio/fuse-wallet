import 'package:equatable/equatable.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/nft_actions.dart';
import 'package:redux/redux.dart';

class TokensListViewModel extends Equatable {
  final List<Token> tokenList;
  final Function() refreshTokenList;

  @override
  List<Object?> get props => [
        tokenList,
      ];

  const TokensListViewModel({
    required this.tokenList,
    required this.refreshTokenList,
  });

  static TokensListViewModel fromStore(Store<AppState> store) {
    List<Token> homeTokens =
        List<Token>.from(store.state.cashWalletState.tokens.values)
            .where((Token token) {
      if ([
        Addresses.nativeTokenAddress,
        Addresses.fusdTokenAddress,
      ].contains(token.address)) {
        return true;
      } else if (num.parse(token.getBalance(true)).compareTo(0) == 1) {
        return true;
      }
      return false;
    }).toList();

    final List<Token> tokens = [...homeTokens]..sort();

    return TokensListViewModel(
      refreshTokenList: () {
        store.dispatch(fetchTokenList());
        store.dispatch(fetchCollectibles());
      },
      tokenList: List<Token>.from(tokens.reversed),
    );
  }
}

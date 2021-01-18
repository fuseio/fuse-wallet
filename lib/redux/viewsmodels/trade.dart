import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/constants/exchangable_tokens.dart';
import 'package:equatable/equatable.dart';

class TradeViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  TradeViewModel({
    this.walletAddress,
    this.tokens,
  });

  static TradeViewModel fromStore(Store<AppState> store) {
    final List<Token> tokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList()
        .reversed
        .toList();
    final List<Token> exchangable = exchangableTokens.values.toList()
      ..removeWhere((Token token) {
        dynamic foundToken = tokens.firstWhere(
            (element) =>
                element.address.toLowerCase() == token.address.toLowerCase(),
            orElse: () => null);
        if (foundToken != null) {
          return true;
        } else
          return false;
      });
    return TradeViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [...tokens, ...exchangable].toSet().toList(),
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}

import 'package:decimal/decimal.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';

class SwapViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final List<Token> payWithTokens;
  final List<Token> receiveTokens;
  final Plugins plugins;

  SwapViewModel({
    required this.walletAddress,
    required this.tokens,
    required this.receiveTokens,
    required this.payWithTokens,
    required this.plugins,
  });

  static SwapViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community? community =
        store.state.cashWalletState.communities[communityAddress];
    final List<Token> tokens = store.state.swapState.tokens.values.toList();
    final Token fusd = store.state.swapState.tokens[fuseDollarToken.address];
    final Token wfuse = store.state.swapState.tokens[wfuseTokenAddress];
    final Token weth = store.state.swapState.tokens[wethTokenAddress];
    final Token wbtc = store.state.swapState.tokens[wbtcTokenAddress];
    final List<Token> payWithTokens = tokens
        .where((Token token) =>
            Decimal.parse(token.getBalance(true)).compareTo(Decimal.zero) == 1)
        .toList();
    final List<Token> receiveTokens = [
      fusd,
      wfuse,
      weth,
      wbtc,
    ]..addAll(
        tokens
          ..removeWhere((element) =>
              element.address == fusd!.address ||
              element.address == wfuse!.address ||
              element.address == weth!.address ||
              element.address == wbtc!.address),
      );

    final List<Token> tokenList = (store.state.swapState?.tokens?.values
            ?.toList() ??
        [])
      ..where(
          (Token token) => num.parse(token.getBalance(true)).compareTo(0) == 1)
      ..sort();

    return SwapViewModel(
      plugins: community?.plugins ?? Plugins(),
      payWithTokens: payWithTokens ?? [],
      receiveTokens: receiveTokens,
      walletAddress: store.state.userState.walletAddress,
      tokens: List<Token>.from(tokenList.reversed),
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        tokens,
        receiveTokens,
        payWithTokens,
      ];
}

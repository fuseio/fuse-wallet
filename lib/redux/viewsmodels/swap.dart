import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
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
    this.walletAddress,
    this.tokens,
    this.receiveTokens,
    this.payWithTokens,
    this.plugins,
  });

  static SwapViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    final List<Token> tokens = store.state.swapState?.tokens?.values?.toList();
    final Token fusd = store.state.swapState?.tokens[fuseDollarToken.address];
    final Token wfuse = tokens?.firstWhere(
        (element) => element.symbol == 'WFUSE',
        orElse: () => null);
    final Token weth = tokens?.firstWhere((element) => element.symbol == 'WETH',
        orElse: () => null);
    final Token wbtc = tokens?.firstWhere((element) => element.symbol == 'WBTC',
        orElse: () => null);
    final List<Token> payWithTokens = tokens
        ?.where((Token token) =>
            num.parse(formatValue(token?.amount, token?.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        ?.toList();
    final List<Token> receiveTokens = [
      fusd,
      wfuse,
      weth,
      wbtc,
    ]..addAll(
        tokens
          ..removeWhere((element) =>
              element.address == fusd.address ||
              element.address == wfuse.address ||
              element.address == weth.address ||
              element.address == wbtc.address),
      );

    return SwapViewModel(
      plugins: community?.plugins ?? Plugins(),
      payWithTokens: payWithTokens,
      receiveTokens: receiveTokens,
      walletAddress: store.state.userState.walletAddress,
      tokens: (store.state.swapState?.tokens?.values?.toList() ?? [])
        ..where((Token token) =>
            num.parse(formatValue(token?.amount, token?.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        ..sort(
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
        ),
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

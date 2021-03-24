import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
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
    return SwapViewModel(
      plugins: community?.plugins ?? Plugins(),
      payWithTokens:
          tokens.where((element) => element.amount > BigInt.zero).toList(),
      receiveTokens: tokens,
      walletAddress: store.state.userState.walletAddress,
      tokens: (store.state.swapState?.tokens?.values?.toList() ?? [])
        ..where((Token token) =>
            num.parse(formatValue(token?.amount, token?.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        ..sort((tokenA, tokenB) => (tokenB?.amount ?? BigInt.zero)?.compareTo(
              tokenA?.amount ?? BigInt.zero,
            )),
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

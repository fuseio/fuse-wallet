import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
// import 'package:fusecash/models/community/community.dart';
// import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
// import 'package:fusecash/utils/log/log.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
// import 'package:fusecash/utils/addresses.dart' as util;

num combiner(num previousValue, Token token) => token?.priceInfo != null && token?.priceInfo?.quote != 'NaN'
    ? previousValue +
        num.parse(Decimal.parse(token?.getFiatBalance()).toString())
    : previousValue + 0;

class BalanceViewModel extends Equatable {
  final String usdValue;
  // final bool hasErc20Tokens;
  // final Token token;

  BalanceViewModel({
    this.usdValue,
    // this.hasErc20Tokens,
    // this.token,
  });

  static BalanceViewModel fromStore(Store<AppState> store) {
    // ProWalletState proWalletState = store.state.proWalletState;
    // List<Token> erc20Tokens =
    //     List<Token>.from(proWalletState.erc20Tokens?.values ?? Iterable.empty())
    //         .where((Token token) =>
    //             num.parse(formatValue(token.amount, token.decimals,
    //                     withPrecision: true))
    //                 .compareTo(0) ==
    //             1)
    //         .toList();
    // String communityAddress = store.state.cashWalletState.communityAddress;
    // Community community =
    //     store.state.cashWalletState.communities[communityAddress] ??
    //         Community();
    CashWalletState cashWalletState = store.state.cashWalletState;
    List<Token> homeTokens =
        List<Token>.from(cashWalletState.tokens?.values ?? Iterable.empty())
            .where((Token token) =>
                num.parse(formatValue(token.amount, token.decimals,
                        withPrecision: true))
                    .compareTo(0) ==
                1)
            .toList();

    final num value = homeTokens.fold<num>(0, combiner);
    // final bool isDefaultCommunity = util.isDefaultCommunity(communityAddress);
    // final Token token = isDefaultCommunity
    //     ? store.state.cashWalletState.tokens[community?.homeTokenAddress]
    //         ?.copyWith(symbol: '\$')
    //     : store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return BalanceViewModel(
      // token: token,
      // hasErc20Tokens: erc20Tokens.isEmpty,
      usdValue: display(value),
    );
  }

  @override
  List<Object> get props => [
        usdValue,
        // hasErc20Tokens,
        // token,
      ];
}

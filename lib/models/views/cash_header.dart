import 'package:decimal/decimal.dart';
import 'package:digitalrand/models/plugins/plugins.dart';
import 'package:digitalrand/models/pro/pro_wallet_state.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final Plugins plugins;
  final String walletStatus;
  final String usdValue;

  CashHeaderViewModel(
      {this.usdValue, this.firstName, this.plugins, this.walletStatus});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    ProWalletState proWalletState = store.state.proWalletState;
    num combiner(
            num previousValue, Token token) =>
        prices.containsKey(token.symbol)
            ? token?.priceInfo != null
                ? previousValue +
                    num.parse(Decimal.parse(token?.priceInfo?.total).toString())
                : previousValue +
                    num.parse(getDollarValue(
                        token.amount, token.decimals, prices[token.symbol],
                        withPrecision: true))
            : previousValue + 0;

    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens =
        List<Token>.from(proWalletState.erc20Tokens?.values ?? Iterable.empty())
            .where((Token token) =>
                num.parse(formatValue(token.amount, token.decimals,
                        withPrecision: false))
                    .compareTo(0) ==
                1)
            .toList();
    List<Token> allTokens = [
      ...communities.map((Community community) => community.token).toList(),
      ...foreignTokens
    ];

    num usdValue = allTokens.fold<num>(0, combiner);
    Decimal decimalValue = Decimal.parse(usdValue.toString());
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return CashHeaderViewModel(
        usdValue: usdValue.compareTo(num.parse('0.01')) != 1
            ? decimalValue.toStringAsFixed(1)
            : decimalValue.isInteger
                ? decimalValue.toString()
                : decimalValue.toStringAsPrecision(2),
        plugins: community?.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props => [plugins, walletStatus, usdValue];
}

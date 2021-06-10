import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

num combiner(num previousValue, Token token) => token.priceInfo!.quote != 'NaN'
    ? previousValue +
        num.parse(Decimal.parse(token.getFiatBalance()).toString())
    : previousValue + 0;

class BalanceViewModel extends Equatable {
  final String usdValue;

  BalanceViewModel({
    required this.usdValue,
  });

  static BalanceViewModel fromStore(Store<AppState> store) {
    CashWalletState cashWalletState = store.state.cashWalletState;
    List<Token> homeTokens = List<Token>.from(cashWalletState.tokens.values)
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .toList();

    final num value = homeTokens.fold<num>(0, combiner);

    return BalanceViewModel(
      usdValue: display(value),
    );
  }

  @override
  List<Object> get props => [
        usdValue,
      ];
}

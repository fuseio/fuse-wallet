import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';

num combiner(num previousValue, Token token) => token.hasPriceInfo
    ? previousValue +
        num.parse(Decimal.parse(token.getFiatBalance(true)).toString())
    : previousValue + 0;

class BalanceViewModel extends Equatable {
  final String usdValue;
  final Function() firstName;

  const BalanceViewModel({
    required this.usdValue,
    required this.firstName,
  });

  static BalanceViewModel fromStore(Store<AppState> store) {
    CashWalletState cashWalletState = store.state.cashWalletState;
    List<Token> homeTokens = List<Token>.from(cashWalletState.tokens.values)
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .toList();

    final num value = homeTokens.fold<num>(0, combiner);

    return BalanceViewModel(
      usdValue: Formatter.padZeroIfNeeded(Decimal.parse(value.toString())),
      firstName: () {
        String fullName = store.state.userState.displayName;
        return fullName.split(' ')[0];
      },
    );
  }

  @override
  List<Object?> get props => [
        usdValue,
      ];
}

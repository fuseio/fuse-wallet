import 'package:equatable/equatable.dart';
// import 'package:supervecina/models/cash_wallet_state.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/utils/constants.dart';
// import 'package:supervecina/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';

// num combiner(num previousValue, Token token) =>
//     ![null, '', '0', 0, 'NaN'].contains(token.priceInfo?.quote)
//         ? previousValue + num.parse(token.getFiatBalance())
//         : previousValue + 0;

class BalanceViewModel extends Equatable {
  // final String usdValue;
  final Token token;

  BalanceViewModel({
    // required this.usdValue,
    required this.token,
  });

  static BalanceViewModel fromStore(Store<AppState> store) {
    // CashWalletState cashWalletState = store.state.cashWalletState;
    // List<Token> homeTokens = List<Token>.from(cashWalletState.tokens.values)
    //     .where((Token token) =>
    //         num.parse(token.getBalance(true)).compareTo(0) == 1)
    //     .toList();

    // final num value = homeTokens.fold<num>(0, combiner);

    return BalanceViewModel(
      // usdValue: display(value),
      token: store.state.cashWalletState.tokens[illaToken.address] ?? illaToken,
    );
  }

  @override
  List<Object> get props => [
        // usdValue,
        token,
      ];
}

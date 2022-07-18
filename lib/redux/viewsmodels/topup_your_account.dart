import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/constants.dart';

class TopupYourAccountViewModel extends Equatable {
  final bool hasFUSD;

  const TopupYourAccountViewModel({
    required this.hasFUSD,
  });

  static TopupYourAccountViewModel fromStore(Store<AppState> store) {
    final List<Token> tokens = store.state.swapState.tokens.values.toList();

    final List<Token> payWithTokens = tokens
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .toList();

    final Token? token = store
        .state.cashWalletState.tokens[fuseDollarToken.address.toLowerCase()];
    final bool hasFUSD =
        Decimal.parse(token?.getBalance(true) ?? '0').compareTo(Decimal.zero) ==
                1 ||
            payWithTokens.isNotEmpty;

    return TopupYourAccountViewModel(
      hasFUSD: hasFUSD,
    );
  }

  @override
  List<Object?> get props => [
        hasFUSD,
      ];
}

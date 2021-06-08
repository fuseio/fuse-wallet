import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class PriceDiffViewModel extends Equatable {
  final Map<String, Token> tokens;
  final Function(
    String tokenAddress,
    String limit,
  ) fetchPriceDiff;

  PriceDiffViewModel({
    this.tokens,
    this.fetchPriceDiff,
  });

  static PriceDiffViewModel fromStore(Store<AppState> store) {
    return PriceDiffViewModel(
      tokens: store.state?.cashWalletState?.tokens,
      fetchPriceDiff: (
        tokenAddress,
        limit,
      ) {
        store.dispatch(
          getTokenPriceDiffCall(
            tokenAddress,
            limit,
          ),
        );
      },
    );
  }

  @override
  List<Object> get props => [
        tokens,
      ];
}

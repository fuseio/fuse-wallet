import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

class TradeViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  TradeViewModel({
    this.walletAddress,
    this.tokens,
  });

  static TradeViewModel fromStore(Store<AppState> store) {
    return TradeViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: store.state.swapState?.tokensList ?? [],
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        tokens,
      ];
}

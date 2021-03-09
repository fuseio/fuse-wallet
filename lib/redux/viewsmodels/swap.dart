import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

class SwapViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  SwapViewModel({
    this.walletAddress,
    this.tokens,
  });

  static SwapViewModel fromStore(Store<AppState> store) {
    return SwapViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: (store.state.swapState?.tokensList ?? [])
        ..where((Token token) =>
            num.parse(formatValue(token?.amount, token?.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1).toList(),
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        tokens,
      ];
}

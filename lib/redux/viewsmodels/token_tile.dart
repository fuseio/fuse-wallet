import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';

class TokenTileViewModel extends Equatable {
  final List<Community> communities;
  final Map<String, String> tokensImages;
  final Function(Token token) fetchTokenAction;
  final Function(Token token) fetchTokenPrice;

  TokenTileViewModel({
    this.communities,
    this.tokensImages,
    this.fetchTokenAction,
    this.fetchTokenPrice,
  });

  static TokenTileViewModel fromStore(Store<AppState> store) {
    return TokenTileViewModel(
      tokensImages: store.state.swapState?.tokensImages ?? Map(),
      communities: store.state.cashWalletState.communities.values.toList(),
      fetchTokenAction: (Token token) {
        store.dispatch(getTokenWalletActionsCall(token));
      },
      fetchTokenPrice: (Token token) {
        store.dispatch(getTokenPriceCall(token));
      },
    );
  }

  @override
  List<Object> get props => [
        communities,
        tokensImages,
      ];
}

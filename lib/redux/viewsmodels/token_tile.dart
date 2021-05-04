import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';

class TokenTileViewModel extends Equatable {
  final List<Community> communities;
  final Map<String, String> tokensImages;
  final Function(Token token) fetchTokenAction;
  final Function(Token token) fetchTokenPrice;
  final Plugins plugins;
  final Function getSwapList;

  TokenTileViewModel({
    this.communities,
    this.plugins,
    this.tokensImages,
    this.fetchTokenAction,
    this.fetchTokenPrice,
    this.getSwapList,
  });

  static TokenTileViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    return TokenTileViewModel(
      plugins: community?.plugins ?? Plugins(),
      tokensImages: store.state.swapState?.tokensImages ?? Map(),
      communities: store.state.cashWalletState.communities.values.toList(),
      fetchTokenAction: (Token token) {
        store.dispatch(getTokenWalletActionsCall(token));
      },
      fetchTokenPrice: (Token token) {
        store.dispatch(getTokenPriceCall(token));
      },
      getSwapList: () {
        store.dispatch(fetchSwapList());
      }
    );
  }

  @override
  List<Object> get props => [
        communities,
        tokensImages,
        plugins,
      ];
}

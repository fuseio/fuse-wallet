import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/plugins/plugins.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:supervecina/models/community/community.dart';

class TokenTileViewModel extends Equatable {
  final List<Community> communities;
  final Map<String, String> tokensImages;
  final Function(Token token) fetchTokenAction;
  final Plugins plugins;

  TokenTileViewModel({
    required this.communities,
    required this.plugins,
    required this.tokensImages,
    required this.fetchTokenAction,
  });

  static TokenTileViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community? community =
        store.state.cashWalletState.communities[communityAddress];
    return TokenTileViewModel(
      plugins: community?.plugins ?? Plugins(),
      tokensImages: {}, // store.state.swapState.tokensImages,
      communities: store.state.cashWalletState.communities.values.toList(),
      fetchTokenAction: (Token token) {
        store.dispatch(getTokenWalletActionsCall(token));
      },
    );
  }

  @override
  List<Object> get props => [
        communities,
        tokensImages,
        plugins,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SwitchCommunityViewModel extends Equatable {
  final Map<String, Community> communities;
  final Map<String, Token> tokens;
  final Community currentCommunity;
  final Function(String) switchCommunity;

  SwitchCommunityViewModel({
    required this.communities,
    required this.switchCommunity,
    required this.currentCommunity,
    required this.tokens,
  });

  static SwitchCommunityViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    return SwitchCommunityViewModel(
      tokens: store.state.cashWalletState.tokens,
      currentCommunity:
          store.state.cashWalletState.communities.containsKey(communityAddres)
              ? store.state.cashWalletState.communities[communityAddres]!
              : Community(),
      communities: store.state.cashWalletState.communities
        ..removeWhere((key, community) =>
            [null, ''].contains(community.address) ||
            [null, ''].contains(community.name)),
      switchCommunity: (String communityAddress) {
        store.dispatch(SwitchCommunityRequested(communityAddress));
        store.dispatch(switchToExistingCommunityCall(communityAddress));
      },
    );
  }

  @override
  List<Object> get props => [communities, currentCommunity, tokens];
}

import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;

class BottomBarViewModel extends Equatable {
  final Community community;
  final bool isDefaultCommunity;

  BottomBarViewModel({
    this.isDefaultCommunity,
    this.community,
  });

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return BottomBarViewModel(
      community: community,
      isDefaultCommunity: util.isDefaultCommunity(communityAddress),
    );
  }

  @override
  List<Object> get props => [isDefaultCommunity, community];
}

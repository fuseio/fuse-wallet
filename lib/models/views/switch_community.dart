import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:peepl/models/community.dart';
import 'package:peepl/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:peepl/models/app_state.dart';

class SwitchCommunityViewModel extends Equatable {
  final Map<String, Community> communities;
  final Community currentCommunity;
  final Function(String) switchCommunity;

  SwitchCommunityViewModel({this.communities, this.switchCommunity, this.currentCommunity});

  static SwitchCommunityViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return SwitchCommunityViewModel(
      currentCommunity: community,
      communities: store.state.cashWalletState.communities,
      switchCommunity: (String communityAddress) {
        store.dispatch(switchCommunityCall(communityAddress));
      },
    );
  }

  @override
  List<Object> get props => [communities, currentCommunity];
}

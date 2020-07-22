import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/utils/addresses.dart' as util;

class BottomBarViewModel extends Equatable {
  final String communityAddres;
  final String walletAddress;
  final bool isDefaultCommunity;
  final List<Contact> contacts;
  final bool isProModeActivate;
  BottomBarViewModel(
      {this.communityAddres,
      this.isDefaultCommunity,
      this.contacts,
      this.isProModeActivate,
      this.walletAddress});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    // Community community = store.state.cashWalletState.communities[communityAddress] ?? new Community.initial();
    return BottomBarViewModel(
        walletAddress: store.state.cashWalletState.walletAddress,
        contacts: store.state.userState.contacts ?? [],
        isProModeActivate: store.state.userState.isProModeActivated,
        communityAddres: communityAddress,
        // community: community,
        isDefaultCommunity: util.isDefaultCommunity(communityAddress));
  }

  @override
  List<Object> get props => [communityAddres, isProModeActivate, contacts, isDefaultCommunity];
}

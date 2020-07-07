import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';

class BottomBarViewModel extends Equatable {
  final String communityAddress;
  final Community community;
  final List<Contact> contacts;

  BottomBarViewModel({this.communityAddress, this.community, this.contacts});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return BottomBarViewModel(
        contacts: store.state.userState.contacts ?? [],
        communityAddress: communityAddress,
        community: community);
  }

  @override
  List<Object> get props => [communityAddress, contacts];
}

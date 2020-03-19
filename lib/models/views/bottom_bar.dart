import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;

class BottomBarViewModel extends Equatable {
  final String communityAddres;
  final bool isDefaultCommunity;
  final List<Contact> contacts;
  final bool isProModeActivate;
  BottomBarViewModel(
      {this.communityAddres,
      this.isDefaultCommunity,
      this.contacts,
      this.isProModeActivate});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    return BottomBarViewModel(
        contacts: store.state.userState.contacts ?? [],
        isProModeActivate: store.state.userState.isProModeActivated,
        communityAddres: communityAddress,
        isDefaultCommunity: util.isDefaultCommunity(communityAddress));
  }

  @override
  List<Object> get props => [communityAddres, isProModeActivate, contacts, isDefaultCommunity];
}

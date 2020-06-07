import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;
import 'package:wallet_core/wallet_core.dart' show EtherAmount, EtherUnit;

class BottomBarViewModel extends Equatable {
  final String communityAddress;
  final Community community;
  final bool isDefaultCommunity;
  final List<Contact> contacts;
  final bool isProModeActivate;
  final List<Token> tokens;

  BottomBarViewModel(
      {this.communityAddress,
      this.isDefaultCommunity,
      this.community,
      this.contacts,
      this.tokens,
      this.isProModeActivate});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    List<Token> tokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? [daiToken])
        .where((Token token) => EtherAmount.inWei(token.amount).getValueInUnit(EtherUnit.ether) > 0)
        .toList()
        .reversed
        .toList();
    return BottomBarViewModel(
      contacts: store.state.userState.contacts ?? [],
      isProModeActivate: store.state.userState.isProModeActivated,
      communityAddress: communityAddress,
      community: community,
      isDefaultCommunity: util.isDefaultCommunity(communityAddress),
      tokens: tokens..sort((a, b) => b.amount.compareTo(a.amount)),
    );
  }

  @override
  List<Object> get props => [
        communityAddress,
        isProModeActivate,
        contacts,
        isDefaultCommunity,
        tokens
      ];
}

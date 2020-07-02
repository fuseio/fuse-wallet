import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final Plugins plugins;
  final String walletStatus;
  final bool isCommunityMember;

  CashHeaderViewModel(
      {this.community,
      this.firstName,
      this.plugins,
      this.walletStatus,
      this.isCommunityMember});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return CashHeaderViewModel(
        community: community,
        plugins: community?.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        isCommunityMember:
            community.isMember && isDefaultCommunity(communityAddres),
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props =>
      [community, plugins, isCommunityMember, walletStatus];
}

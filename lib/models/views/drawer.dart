import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class DrawerViewModel extends Equatable {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final String communityAddress;
  final bool isBackup;
  final Plugins plugins;
  final Function() firstName;

  DrawerViewModel(
      {this.logout,
      this.walletStatus,
      this.plugins,
      this.isBackup,
      this.walletAddress,
      this.firstName,
      this.communityAddress});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return DrawerViewModel(
        isBackup: store.state.userState.backup ?? false,
        communityAddress: communityAddress,
        walletAddress: store.state.userState.walletAddress,
        plugins: community?.plugins,
        walletStatus: store.state.userState.walletStatus,
        logout: () {
          store.dispatch(logoutCall());
        },
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List get props =>
      [walletStatus, walletAddress, communityAddress];
}

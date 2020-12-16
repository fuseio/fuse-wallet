import 'package:equatable/equatable.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/plugins/plugins.dart';
import 'package:redux/redux.dart';
import 'package:esol/models/community/community.dart';
import 'package:esol/redux/actions/user_actions.dart';

class DrawerViewModel extends Equatable {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final String avatarUrl;
  final bool isBackup;
  final Plugins plugins;
  final Function() firstName;
  final bool isFaceVerified;

  DrawerViewModel(
      {this.logout,
      this.isFaceVerified,
      this.walletStatus,
      this.plugins,
      this.isBackup,
      this.walletAddress,
      this.avatarUrl,
      this.firstName});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    return DrawerViewModel(
        isFaceVerified: store.state.userState?.isFaceVerified ?? false,
        isBackup: store.state.userState.backup ?? false,
        walletAddress: store.state.userState.walletAddress,
        plugins: community?.plugins ?? Plugins(),
        walletStatus: store.state.userState.walletStatus,
        avatarUrl: store.state.userState.avatarUrl,
        logout: () {
          store.dispatch(logoutCall());
        },
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List get props => [walletStatus, walletAddress, plugins, isFaceVerified];
}

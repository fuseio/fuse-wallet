
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class DrawerViewModel {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final String communityAddress;
  final Plugins plugins;
  final Function() firstName;
  final Function(bool isProMode) replaceNavigator;

  DrawerViewModel(
      {this.logout,
      this.walletStatus,
      this.plugins,
      this.walletAddress,
      this.firstName,
      this.communityAddress,
      this.replaceNavigator});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return DrawerViewModel(
        communityAddress: communityAddress,
        walletAddress: store.state.cashWalletState.walletAddress,
        plugins: community?.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        logout: () {
          store.dispatch(logoutCall());
        },
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        },
        replaceNavigator: (isProMode) {
          store.dispatch(SwitchWalletMode(isProMode: isProMode));
        });
  }
}

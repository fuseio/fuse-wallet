
import 'package:equatable/equatable.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/community.dart';
import 'package:supervecina/models/plugins.dart';
import 'package:supervecina/redux/actions/user_actions.dart';

class DrawerViewModel extends Equatable {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final String communityAddress;
  final bool isProModeActivate;
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
      this.replaceNavigator,
      this.isProModeActivate});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddress] ?? new Community.initial();
    return DrawerViewModel(
        isProModeActivate: store.state.userState.isProModeActivated ?? false,
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

  @override
  List get props => [walletStatus, walletAddress, communityAddress, isProModeActivate];
}

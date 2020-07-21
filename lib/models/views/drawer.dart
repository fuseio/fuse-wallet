import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class DrawerViewModel extends Equatable {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final bool isBackup;
  final Function() firstName;

  DrawerViewModel({
    this.logout,
    this.walletStatus,
    this.isBackup,
    this.walletAddress,
    this.firstName,
  });

  static DrawerViewModel fromStore(Store<AppState> store) {

    return DrawerViewModel(
        isBackup: store.state.userState.backup ?? false,
        walletAddress: store.state.userState.walletAddress,
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
  List get props => [walletStatus, walletAddress];
}

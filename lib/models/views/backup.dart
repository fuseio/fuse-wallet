import 'package:equatable/equatable.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/user_state.dart';
import 'package:esol/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class BackupViewModel extends Equatable {
  final UserState user;
  final Function() backupWallet;

  BackupViewModel({
    this.user,
    this.backupWallet,
  });

  static BackupViewModel fromStore(Store<AppState> store) {
    return BackupViewModel(
        user: store.state.userState,
        backupWallet: () {
          store.dispatch(backupWalletCall());
        });
  }

  @override
  List<Object> get props => [user];
}

class LockScreenViewModel extends Equatable {
  final String pincode;

  LockScreenViewModel({this.pincode});

  static LockScreenViewModel fromStore(Store<AppState> store) {
    return LockScreenViewModel(
      pincode: store.state.userState.pincode,
    );
  }

  @override
  List<Object> get props => [pincode];
}

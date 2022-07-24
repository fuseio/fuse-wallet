import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class BackupViewModel extends Equatable {
  final Function() backupWallet;
  final List<String> userMnemonic;

  const BackupViewModel({
    required this.backupWallet,
    required this.userMnemonic,
  });

  static BackupViewModel fromStore(Store<AppState> store) {
    return BackupViewModel(
      userMnemonic: store.state.userState.mnemonic,
      backupWallet: () {
        store.dispatch(BackupSuccess());
      },
    );
  }

  @override
  List<Object?> get props => [userMnemonic];
}

class LockScreenViewModel extends Equatable {
  final String pincode;

  const LockScreenViewModel({
    required this.pincode,
  });

  static LockScreenViewModel fromStore(Store<AppState> store) {
    return LockScreenViewModel(
      pincode: store.state.userState.pincode,
    );
  }

  @override
  List<Object?> get props => [pincode];
}

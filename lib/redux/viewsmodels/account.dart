import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class AccountViewModel extends Equatable {
  final String walletAddress;
  final String avatarUrl;
  final String displayName;
  final bool isBackup;

  AccountViewModel({
    required this.walletAddress,
    required this.avatarUrl,
    required this.displayName,
    required this.isBackup,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    return AccountViewModel(
      isBackup: store.state.userState.backup,
      displayName: store.state.userState.displayName,
      avatarUrl: store.state.userState.avatarUrl,
      walletAddress: store.state.userState.walletAddress,
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        avatarUrl,
        displayName,
        isBackup,
      ];
}

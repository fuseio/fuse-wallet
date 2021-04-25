import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class AccountViewModel extends Equatable {
  final String walletAddress;
  final String avatarUrl;
  final String displayName;

  AccountViewModel({
    this.walletAddress,
    this.avatarUrl,
    this.displayName,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    return AccountViewModel(
      displayName: store.state.userState.displayName,
      avatarUrl: store.state.userState.avatarUrl,
      walletAddress:
          store.state.userState?.walletAddress?.replaceFirst('x', 'f') ?? '',
    );
  }

  @override
  List<Object> get props => [
        walletAddress,
        avatarUrl,
        displayName,
      ];
}

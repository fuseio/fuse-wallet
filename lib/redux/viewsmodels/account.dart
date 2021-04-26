import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:redux/redux.dart';

class AccountViewModel extends Equatable {
  final String walletAddress;
  final String avatarUrl;
  final String displayName;
  final Plugins plugins;

  AccountViewModel({
    this.plugins,
    this.walletAddress,
    this.avatarUrl,
    this.displayName,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    return AccountViewModel(
      plugins: community?.plugins ?? Plugins(),
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

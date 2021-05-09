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
  final bool isBackup;

  AccountViewModel({
    required this.plugins,
    required this.walletAddress,
    required this.avatarUrl,
    required this.displayName,
    required this.isBackup,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    return AccountViewModel(
      isBackup: store.state.userState.backup ?? false,
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
        isBackup,
        plugins,
      ];
}

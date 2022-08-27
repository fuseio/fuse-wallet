import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:redux/redux.dart';

class AccountViewModel extends Equatable {
  final String walletAddress;
  final String avatarUrl;
  final String displayName;
  final Function getSwapListBalances;
  final bool isBackup;
  final bool hasPreviousSessions;
  final String? privateKeyForDID;

  const AccountViewModel({
    required this.walletAddress,
    required this.avatarUrl,
    required this.getSwapListBalances,
    required this.displayName,
    required this.isBackup,
    required this.hasPreviousSessions,
    required this.privateKeyForDID,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    return AccountViewModel(
      hasPreviousSessions:
          store.state.cashWalletState.wcSessionStores.isNotEmpty,
      isBackup: store.state.userState.backup,
      displayName: store.state.userState.displayName,
      avatarUrl: store.state.userState.avatarUrl,
      walletAddress: store.state.userState.walletAddress,
      privateKeyForDID: store.state.userState.privateKeyForDID,
      getSwapListBalances: () {
        store.dispatch(fetchSwapBalances());
      },
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
        avatarUrl,
        displayName,
        isBackup,
        hasPreviousSessions,
      ];
}

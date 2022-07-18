import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:wallet_connect/wc_session_store.dart';

class ConnectedDAppsViewModel extends Equatable {
  final List<WCSessionStore> wcSessionStores;
  final Function(WCSessionStore session) removeSession;

  const ConnectedDAppsViewModel({
    required this.wcSessionStores,
    required this.removeSession,
  });

  static ConnectedDAppsViewModel fromStore(Store<AppState> store) {
    return ConnectedDAppsViewModel(
      wcSessionStores: store.state.cashWalletState.wcSessionStores,
      removeSession: (WCSessionStore sessionStore) {
        store.dispatch(
          RemoveSession(
            sessionStore,
          ),
        );
      },
    );
  }

  @override
  List<Object?> get props => [
        wcSessionStores,
      ];
}

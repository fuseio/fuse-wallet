import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class MainScreenViewModel {
  final String countryCode;
  final Function(bool value) resetJustClaim;
  final bool justClaimed;
  MainScreenViewModel({
    required this.countryCode,
    required this.justClaimed,
    required this.resetJustClaim,
  });

  static MainScreenViewModel fromStore(Store<AppState> store) {
    return MainScreenViewModel(
      countryCode: store.state.userState.countryCode,
      justClaimed: store.state.cashWalletState.justClaimed,
      resetJustClaim: (bool value) {
        store.dispatch(ResetJustClaim(value));
      },
    );
  }
}

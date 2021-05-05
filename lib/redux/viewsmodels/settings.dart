import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class SettingsViewModel {
  final Function() logout;

  SettingsViewModel({
    this.logout,
  });

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      logout: () {
        store.dispatch(logoutCall());
      },
    );
  }
}

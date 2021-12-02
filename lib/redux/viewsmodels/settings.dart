import 'package:supervecina/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/redux/actions/user_actions.dart';

class SettingsViewModel {
  final Function() logout;

  SettingsViewModel({
    required this.logout,
  });

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      logout: () {
        store.dispatch(logoutCall());
      },
    );
  }
}

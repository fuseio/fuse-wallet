import 'package:supervecina/models/app_state.dart';
import 'package:redux/redux.dart';

class MainScreenViewModel {
  final String countryCode;
  MainScreenViewModel({
    required this.countryCode,
  });

  static MainScreenViewModel fromStore(Store<AppState> store) {
    return MainScreenViewModel(
      countryCode: store.state.userState.countryCode,
    );
  }
}

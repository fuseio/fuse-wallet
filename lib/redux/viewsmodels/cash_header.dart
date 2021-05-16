import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class CashHeaderViewModel {
  final Function() firstName;

  CashHeaderViewModel({
    required this.firstName,
  });

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    return CashHeaderViewModel(
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      },
    );
  }
}

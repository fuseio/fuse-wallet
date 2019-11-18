import 'package:fusecash/redux/state/app_state.dart';
import 'package:fusecash/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducers(state.userState, action)
  );
}
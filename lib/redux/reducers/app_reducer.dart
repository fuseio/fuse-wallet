import 'package:roost/models/app_state.dart';
import 'package:roost/redux/reducers/user_reducer.dart';
import 'package:roost/redux/reducers/cash_wallet_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducers(state.userState, action),
    cashWalletState: cashWalletReducers(state.cashWalletState, action)
  );
}
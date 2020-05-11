import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/redux/reducers/pro_mode_reducer.dart';
import 'package:digitalrand/redux/reducers/user_reducer.dart';
import 'package:digitalrand/redux/reducers/cash_wallet_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducers(state.userState, action),
    cashWalletState: cashWalletReducers(state.cashWalletState, action),
    proWalletState: proWalletReducers(state.proWalletState, action)
  );
}
import 'package:paywise/models/user_state.dart';
import 'package:paywise/models/cash_wallet_state.dart';

class AppState {
  final UserState userState;
  final CashWalletState cashWalletState;

  AppState({
    this.userState,
    this.cashWalletState
  });

  factory AppState.initial() {

    return AppState(
      userState: UserState.initial(),
      cashWalletState: CashWalletState.initial()
    );
  }

  AppState copyWith(
    UserState userState,
    CashWalletState cashWalletState
  ) {
    return AppState(
      userState: userState ?? this.userState,
      cashWalletState: cashWalletState ?? this.cashWalletState
    );
  }

  static AppState fromJson(dynamic json) =>
    AppState(userState: UserState.fromJson(json['userState']),
      cashWalletState: CashWalletState.fromJson(json['cashWalletState']));
  
  dynamic toJson() => {
    'userState': userState.toJson(),
    'cashWalletState': cashWalletState.toJson()
  };
}

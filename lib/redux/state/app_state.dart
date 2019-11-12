import 'package:flutter/widgets.dart';

class AppState {
  //final UserState userState;
  //final WalletState walletState;

  AppState();

  factory AppState.initial() {
    return AppState(
      //userState: UserState.initial(),
      //walletState: WalletState.initial(),
    );
  }

  AppState copyWith(
    //UserState userState,
    //WalletState walletState,
  ) {
    return AppState(
      //userState: userState ?? this.userState,
      //walletState: walletState ?? this.walletState,
    );
  }

  static AppState fromJson(dynamic json) =>
      AppState();

  dynamic toJson() => {'userState': null, 'walletState': null};
}

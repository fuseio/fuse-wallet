import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

@JsonSerializable(explicitToJson: true)
class AppState {
  final UserState userState;
  final CashWalletState cashWalletState;
  final ProWalletState proWalletState;

  AppState({this.userState, this.cashWalletState, this.proWalletState});

  factory AppState.initial() {
    return AppState(
        userState: UserState.initial(),
        cashWalletState: CashWalletState.initial(),
        proWalletState: ProWalletState.initial());
  }

  AppState copyWith(UserState userState, CashWalletState cashWalletState,
      ProWalletState proWalletState) {
    return AppState(
        userState: userState ?? this.userState,
        cashWalletState: cashWalletState ?? this.cashWalletState,
        proWalletState: proWalletState ?? this.proWalletState);
  }

  static AppState fromJson(dynamic json) => _$AppStateFromJson(json);

  dynamic toJson() => _$AppStateToJson(this);
}

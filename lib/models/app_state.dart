import 'package:esol/models/user_state.dart';
import 'package:esol/models/cash_wallet_state.dart';
import 'package:esol/models/pro/pro_wallet_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

@JsonSerializable(explicitToJson: true)
class AppState {
  final UserState userState;
  final CashWalletState cashWalletState;
  @JsonKey(fromJson: _proStateFromJson)
  final ProWalletState proWalletState;

  static ProWalletState _proStateFromJson(Map<String, dynamic> json) =>
      json == null ? ProWalletState.initial() : ProWalletState.fromJson(json);

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

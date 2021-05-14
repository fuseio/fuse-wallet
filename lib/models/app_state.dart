import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@immutable
@freezed
class AppState with _$AppState {
  const AppState._();

  @JsonSerializable()
  factory AppState({
    @UserStateConverter() @Default(null) UserState userState,
    @CashWalletStateConverter() @Default(null) CashWalletState cashWalletState,
    @ProWalletStateConverter() @Default(null) ProWalletState proWalletState,
    @Default(null) SwapState swapState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
      cashWalletState: CashWalletState.initial(),
      proWalletState: ProWalletState.initial(),
    );
  }

  factory AppState.fromJson(dynamic json) => _$AppStateFromJson(json);
}

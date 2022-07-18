import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/nft/state.dart';
import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/user_state.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  factory AppState({
    @NftsStateConverter() required NftsState nftsState,
    @UserStateConverter() required UserState userState,
    @CashWalletStateConverter() required CashWalletState cashWalletState,
    @SwapStateConverter() required SwapState swapState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      nftsState: NftsState(),
      userState: UserState.initial(),
      cashWalletState: CashWalletState.initial(),
      swapState: SwapState.initial(),
    );
  }

  factory AppState.fromJson(dynamic json) => _$AppStateFromJson(json);
}

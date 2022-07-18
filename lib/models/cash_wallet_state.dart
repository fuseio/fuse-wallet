import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:wallet_connect/wallet_connect.dart';

part 'cash_wallet_state.freezed.dart';
part 'cash_wallet_state.g.dart';

WalletActions walletActionsFromJson(Map<String, dynamic>? walletActions) =>
    walletActions == null
        ? WalletActions.initial()
        : WalletActions.fromJson(walletActions);

Map<String, Token> tokensFromJson(Map<String, dynamic> tokens) => tokens.map(
      (k, e) {
        if (k == Addresses.zeroAddress) {
          return MapEntry(
            Addresses.nativeTokenAddress,
            Token.fromJson(
              {
                ...e as Map<String, dynamic>,
                'address': Addresses.nativeTokenAddress,
              },
            ),
          );
        } else {
          return MapEntry(
            k,
            Token.fromJson(
              e as Map<String, dynamic>,
            ),
          );
        }
      },
    )
      ..putIfAbsent(
        Addresses.nativeTokenAddress,
        () => fuseToken,
      )
      ..putIfAbsent(
        Addresses.fusdTokenAddress,
        () => fuseDollarToken,
      );

@freezed
class CashWalletState with _$CashWalletState {
  const CashWalletState._();

  factory CashWalletState({
    @JsonKey(fromJson: tokensFromJson) @Default({}) Map<String, Token> tokens,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
    @JsonKey(ignore: true) @Default(false) bool isTransfersFetchingStarted,
    @JsonKey(ignore: true) @Default(false) bool isFetchingBalances,
    @Default([]) List<WCSessionStore> wcSessionStores,
  }) = _CashWalletState;

  factory CashWalletState.initial() {
    return CashWalletState(
      tokens: const {},
      walletActions: WalletActions().copyWith(
        list: <WalletAction>[],
        updatedAt: 0,
      ),
    );
  }

  factory CashWalletState.fromJson(dynamic json) =>
      _$CashWalletStateFromJson(json);
}

class CashWalletStateConverter
    implements JsonConverter<CashWalletState, Map<String, dynamic>?> {
  const CashWalletStateConverter();

  @override
  CashWalletState fromJson(Map<String, dynamic>? json) =>
      json != null ? CashWalletState.fromJson(json) : CashWalletState.initial();

  @override
  Map<String, dynamic> toJson(CashWalletState instance) => instance.toJson();
}

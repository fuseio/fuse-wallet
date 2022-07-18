import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/nft_actions.dart';

class SendAmountViewModel extends Equatable {
  final List<Token> tokens;

  final Function(
    Token token,
    String phoneNumber,
    String amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendToContact;

  final Function(
    Collectible collectible,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String? receiverAddress,
    String? phoneNumber,
  }) sendERC721;

  final Function(
    Token token,
    String receiverAddress,
    String amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendToAccountAddress;

  @override
  List<Object?> get props => [tokens];

  const SendAmountViewModel({
    required this.tokens,
    required this.sendToContact,
    required this.sendToAccountAddress,
    required this.sendERC721,
  });

  static SendAmountViewModel fromStore(Store<AppState> store) {
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .toList();

    final List<Token> tokens = [...homeTokens]..sort();
    return SendAmountViewModel(
      tokens: List<Token>.from(tokens.reversed),
      sendERC721: (
        Collectible collectible,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String? receiverAddress,
        String? phoneNumber,
      }) {
        store.dispatch(handleSendERC721(
          collectible,
          sendSuccessCallback,
          sendFailureCallback,
          phoneNumber: phoneNumber,
          receiverAddress: receiverAddress,
        ));
      },
      sendToContact: (
        Token token,
        String phoneNumber,
        String amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(sendTokenToContactCall(
          token,
          phoneNumber,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
      sendToAccountAddress: (
        Token token,
        String receiverAddress,
        String amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(sendTokenCall(
          token,
          receiverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }
}

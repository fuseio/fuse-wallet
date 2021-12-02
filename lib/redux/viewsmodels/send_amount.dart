import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel extends Equatable {
  final List<Token> tokens;

  final Function(
    Token token,
    String phoneNumber,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendToContact;

  final Function(
    Token token,
    String receiverAddress,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) sendToAccountAddress;

  @override
  List<Object?> get props => [tokens];

  SendAmountViewModel({
    required this.tokens,
    required this.sendToContact,
    required this.sendToAccountAddress,
  });

  static SendAmountViewModel fromStore(Store<AppState> store) {
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .toList();

    final List<Token> tokens = [...homeTokens]..sort();
    return SendAmountViewModel(
      tokens: List<Token>.from(tokens.reversed),
      sendToContact: (
        Token token,
        String phoneNumber,
        num amount,
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
        num amount,
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

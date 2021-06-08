import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel extends Equatable {
  final List<Token> tokens;
  final List<Community> communities;

  final Function(
    Token token,
    String receiverAddress,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
  }) sendToForeignMultiBridge;

  final Function(
    Token token,
    String receiverAddress,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
  }) sendToHomeMultiBridge;

  final Function(
    Token token,
    String phoneNumber,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
    String transferNote,
  }) sendToContact;

  final Function(
    Token token,
    String name,
    String phoneNumber,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
    String transferNote,
  }) sendERC20ToContact;
  final Function(
    Token token,
    String receiverAddress,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
    String transferNote,
  }) sendToAccountAddress;

  final Function(
    Token token,
    String receiverAddress,
    num amount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback, {
    String receiverName,
    String transferNote,
  }) sendToErc20Token;

  @override
  List<Object> get props => [tokens, communities];

  SendAmountViewModel({
    this.tokens,
    this.communities,
    this.sendToContact,
    this.sendToAccountAddress,
    this.sendToErc20Token,
    this.sendERC20ToContact,
    this.sendToForeignMultiBridge,
    this.sendToHomeMultiBridge,
  });

  static SendAmountViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(token?.getBalance(true)).compareTo(0) == 1)
        .toList();

    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .where((Token token) =>
            num.parse(token.getBalance(true)).compareTo(0) == 1)
        .map((Token token) => token.copyWith(
            imageUrl: token.imageUrl != null
                ? token.imageUrl
                : store.state.cashWalletState.communities
                        .containsKey(token.communityAddress)
                    ? store.state.cashWalletState
                        .communities[token.communityAddress]?.metadata
                        ?.getImageUri()
                    : null))
        .toList();

    final List<Token> tokens = [...homeTokens, ...foreignTokens]..sort();
    return SendAmountViewModel(
      tokens: List<Token>.from(tokens.reversed) ?? [],
      communities: communities,
      sendToContact: (
        Token token,
        String phoneNumber,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String? receiverName,
        String? transferNote,
      }) {
        store.dispatch(sendTokenToContactCall(
          token,
          phoneNumber,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
          transferNote: transferNote,
        ));
      },
      sendERC20ToContact: (
        Token token,
        String name,
        String phoneNumber,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String receiverName,
        String transferNote,
      }) {
        store.dispatch(sendErc20TokenToContactCall(
          token,
          name,
          phoneNumber,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
        ));
      },
      sendToAccountAddress: (
        Token token,
        String receiverAddress,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String receiverName,
        String transferNote,
      }) {
        store.dispatch(sendTokenCall(
          token,
          receiverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
          transferNote: transferNote,
        ));
      },
      sendToErc20Token: (
        Token token,
        String receiverAddress,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String receiverName,
        String transferNote,
      }) {
        store.dispatch(sendErc20TokenCall(
          token,
          receiverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
          transferNote: transferNote,
        ));
      },
      sendToForeignMultiBridge: (
        Token token,
        String receiverAddress,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String receiverName,
      }) {
        store.dispatch(sendTokenToForeignMultiBridge(
          token,
          receiverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
        ));
      },
      sendToHomeMultiBridge: (
        Token token,
        String receiverAddress,
        num amount,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback, {
        String receiverName,
      }) {
        store.dispatch(sendTokenToHomeMultiBridge(
          token,
          receiverAddress,
          amount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
        ));
      },
    );
  }
}

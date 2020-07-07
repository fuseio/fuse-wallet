import 'package:digitalrand/utils/format.dart';
import 'package:digitalrand/utils/transaction_row.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/redux/actions/pro_mode_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel extends Equatable {
  final String myCountryCode;
  final Community community;
  final List<Token> tokens;
  final Function(
      Token token,
      String name,
      String phoneNumber,
      num,
      String receiverName,
      String transferNote,
      VoidCallback,
      VoidCallback) sendToContact;
  final Function(
      Token token,
      String name,
      String phoneNumber,
      num,
      String receiverName,
      String transferNote,
      VoidCallback,
      VoidCallback) sendERC20ToContact;
  final Function(Token token, String, num, String receiverName,
      String transferNote, VoidCallback, VoidCallback) sendToAccountAddress;
  final Function(String eventName, {Map<String, dynamic> properties})
      trackTransferCall;
  final Function(Map<String, dynamic> traits) idenyifyCall;

  final Function(
    Token token,
    String recieverAddress,
    num amount,
    VoidCallback,
    VoidCallback, {
    String receiverName,
    String transferNote,
  }) sendToErc20Token;

  @override
  List<Object> get props => [tokens, myCountryCode, community];

  SendAmountViewModel({
    this.tokens,
    this.myCountryCode,
    this.sendToContact,
    this.sendToAccountAddress,
    this.trackTransferCall,
    this.idenyifyCall,
    this.community,
    this.sendToErc20Token,
    this.sendERC20ToContact,
  });

  static SendAmountViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: false))
                .compareTo(0) ==
            1)
        .toList();

    List<Token> homeTokens = communities
        .where((Community community) =>
            num.parse(formatValue(
                    community.token.amount, community.token.decimals,
                    withPrecision: false))
                .compareTo(0) ==
            1)
        .map((Community community) => community.token
            .copyWith(imageUrl: getIPFSImageUrl(community.metadata.image)))
        .toList();
    return SendAmountViewModel(
        community: community,
        tokens: [...homeTokens, ...foreignTokens],
        myCountryCode: store.state.userState.countryCode,
        sendToContact: (
          Token token,
          String name,
          String phoneNumber,
          num amount,
          String receiverName,
          String transferNote,
          VoidCallback sendSuccessCallback,
          VoidCallback sendFailureCallback,
        ) {
          store.dispatch(sendTokenToContactCall(token, name, phoneNumber,
              amount, sendSuccessCallback, sendFailureCallback,
              receiverName: receiverName));
        },
        sendERC20ToContact: (
          Token token,
          String name,
          String phoneNumber,
          num amount,
          String receiverName,
          String transferNote,
          VoidCallback sendSuccessCallback,
          VoidCallback sendFailureCallback,
        ) {
          store.dispatch(sendErc20TokenToContactCall(token, name, phoneNumber,
              amount, sendSuccessCallback, sendFailureCallback,
              receiverName: receiverName));
        },
        sendToAccountAddress: (
          Token token,
          String recieverAddress,
          num amount,
          String receiverName,
          String transferNote,
          VoidCallback sendSuccessCallback,
          VoidCallback sendFailureCallback,
        ) {
          store.dispatch(sendTokenCall(
            token,
            recieverAddress,
            amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: receiverName,
          ));
        },
        sendToErc20Token: (
          Token token,
          String recieverAddress,
          num amount,
          VoidCallback sendSuccessCallback,
          VoidCallback sendFailureCallback, {
          String receiverName,
          String transferNote,
        }) {
          store.dispatch(sendErc20TokenCall(
            token,
            recieverAddress,
            amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: receiverName,
          ));
        },
        trackTransferCall: (String eventName,
            {Map<String, dynamic> properties}) {
          store.dispatch(segmentTrackCall(eventName, properties: properties));
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }
}

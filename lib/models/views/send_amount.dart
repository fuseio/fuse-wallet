import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel {
  final Token token;
  final String myCountryCode;
  final Function(String, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToContact;
  final Function(String, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToAccountAddress;

  SendAmountViewModel(
      {this.token,
      this.myCountryCode,
      this.sendToContact,
      this.sendToAccountAddress});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return SendAmountViewModel(
        token: community.token,
        myCountryCode: store.state.userState.countryCode,
        sendToContact: (
            String phoneNumber,
            num amount,
            String receiverName,
            String transferNote,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback,
        ) {
          store.dispatch(sendTokenToContactCall(
              phoneNumber, amount, sendSuccessCallback, sendFailureCallback, receiverName: receiverName));
        },
        sendToAccountAddress: (
          String recieverAddress,
            num amount,
            String receiverName,
            String transferNote,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback,
          ) {
          store.dispatch(sendTokenCall(recieverAddress, amount,
              sendSuccessCallback, sendFailureCallback, receiverName: receiverName, ));
        });
  }
}

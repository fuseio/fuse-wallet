import 'package:flutter/material.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/community.dart';
import 'package:paywise/models/token.dart';
import 'package:paywise/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel {
  final Token token;
  final String myCountryCode;
  final Function(String, num, VoidCallback, VoidCallback, String receiverName) sendToContact;
  final Function(String, num, VoidCallback, VoidCallback, String receiverName) sendToAccountAddress;

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
        sendToContact: (String phoneNumber,
            num amount,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback,
            String receiverName) {
          store.dispatch(sendTokenToContactCall(
              phoneNumber, amount, sendSuccessCallback, sendFailureCallback, receiverName: receiverName));
        },
        sendToAccountAddress: (String recieverAddress,
            num amount,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback,
            String receiverName) {
          store.dispatch(sendTokenCall(recieverAddress, amount,
              sendSuccessCallback, sendFailureCallback, receiverName: receiverName));
        });
  }
}

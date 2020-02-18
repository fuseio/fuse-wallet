import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel {
  final Token token;
  final String myCountryCode;
  final Function(String name, String phoneNumber, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToContact;
  final Function(String, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToAccountAddress;
  final Function(String eventName) trackTransferCall;

  SendAmountViewModel(
      {this.token,
      this.myCountryCode,
      this.sendToContact,
      this.sendToAccountAddress,
      this.trackTransferCall});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return SendAmountViewModel(
        token: community.token,
        myCountryCode: store.state.userState.countryCode,
        sendToContact: (
            String name,
            String phoneNumber,
            num amount,
            String receiverName,
            String transferNote,
            VoidCallback sendSuccessCallback,
            VoidCallback sendFailureCallback,
        ) {
          store.dispatch(sendTokenToContactCall(
            name,
            phoneNumber,
            amount,
            sendSuccessCallback,
            sendFailureCallback,
            receiverName: receiverName
          ));
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
        },
        trackTransferCall: (String eventName) {
          store.dispatch(segmentTrackCall(eventName));
        });
  }
}

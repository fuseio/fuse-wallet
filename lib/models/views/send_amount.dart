import 'package:flutter/material.dart';
import 'package:supervenica/models/app_state.dart';
import 'package:supervenica/models/community.dart';
import 'package:supervenica/models/token.dart';
import 'package:supervenica/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class SendAmountViewModel {
  final Token token;
  final bool isProMode;
  final String myCountryCode;
  final Community community;
  final Function(String name, String phoneNumber, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToContact;
  final Function(String, num, String receiverName, String transferNote, VoidCallback, VoidCallback) sendToAccountAddress;
  final Function(String eventName, {Map<String, dynamic> properties}) trackTransferCall;
  final Function(Map<String, dynamic> traits) idenyifyCall;

  SendAmountViewModel(
      {this.token,
      this.myCountryCode,
      this.sendToContact,
      this.sendToAccountAddress,
      this.trackTransferCall,
      this.idenyifyCall,
      this.isProMode,
      this.community});

  static SendAmountViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return SendAmountViewModel(
        isProMode: store.state.userState.isProMode ?? false,
        token: community.token,
        community: community,
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
        trackTransferCall: (String eventName, {Map<String, dynamic> properties}) {
          store.dispatch(segmentTrackCall(eventName, properties: properties));
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }
}

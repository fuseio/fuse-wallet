import 'package:flutter/material.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallet_connect_flutter/wallet_connect_flutter.dart';

import 'connect_response_model.dart';

class DAppWalletConnectSendTX extends StatelessWidget {
  final BuildContext context;
  final String toWalletAddress;
  final String fromWalletAddress;
  final double amount;

  final ConnectResponse connectResponse;
  final WalletConnectFlutter conn;

  DAppWalletConnectSendTX(this.context, this.connectResponse, this.conn,
      this.toWalletAddress, this.fromWalletAddress, this.amount);

  Future<dynamic> showBottomSheet() {
    return showBarModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (_) => buildTransactionDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildTransactionDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: MyScaffold(
          title: "Approve Transcation",
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Hero(
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFE0E0E0),
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/anom.png'),
                    ),
                    tag: "contactSent",
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(connectResponse.meta.url),
                ),
                Text("would you like to approve the transcation?"),
                Text("Transcation Details"),
                Container(
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 2,
                            color: Colors.black,
                            style: BorderStyle.none)),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("To:"), Text(toWalletAddress)],
                        ),
                        Row(
                          children: [Text("Amount:"), Text(amount.toString())],
                        ),
                      ],
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _onRejectPressed();
                        },
                        child: Text("Reject"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.white))),
                    ElevatedButton(
                        onPressed: () {
                          _onApprovePressed();
                        },
                        child: Text("Approve"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.green[300]))),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _onApprovePressed() async {}

  void _onRejectPressed() async {}
}

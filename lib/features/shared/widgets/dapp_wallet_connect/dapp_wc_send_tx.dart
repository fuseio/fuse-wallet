import 'package:flutter/material.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'connect_response_model.dart';

class DAppWalletConnectSendTX extends StatelessWidget {
  final BuildContext context;
  final String toWalletAddress;
  final String fromWalletAddress;
  final num amount;

  final ConnectResponse connectResponse;
  final dynamic approveSend;
  DAppWalletConnectSendTX(
      this.context,
      this.connectResponse,
      this.toWalletAddress,
      this.fromWalletAddress,
      this.amount,
      this.approveSend);

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Hero(
                    child: connectResponse.meta.icons[2].isEmpty
                        ? CircleAvatar(
                            backgroundColor: Color(0xFFE0E0E0),
                            radius: 35,
                            backgroundImage:
                                AssetImage('assets/images/anom.png'),
                          )
                        : CircleAvatar(
                            backgroundColor: Color(0xFFE0E0E0),
                            radius: 35,
                            backgroundImage:
                                NetworkImage(connectResponse.meta.icons[2]),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("To:")),
                            Expanded(child: Text(toWalletAddress))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Amount:"),
                            Text(
                              amount.toString(),
                            )
                          ],
                        ),
                      ],
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _onRejectPressed();
                        },
                        child: Text("Reject"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.white))),
                    SizedBox(
                      width: 30,
                    ),
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

  void _onApprovePressed() async {
    this.approveSend;
    Navigator.pop(context);
  }

  void _onRejectPressed() async {}
}

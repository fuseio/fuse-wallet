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
      height: MediaQuery.of(context).size.height * 0.7,
      child: MyScaffold(
          title: "Approve Transcation",
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
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
                  Text(
                    "would you like to approve the transcation?",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Transcation Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                    child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2,
                                color: Colors.black,
                                style: BorderStyle.solid)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 30),
                              child: Row(
                                children: [
                                  Text(
                                    "To: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(toWalletAddress),
                                  ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      "Amount: ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      amount.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  width: 1.5,
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          child: MaterialButton(
                            onPressed: () {
                              _onRejectPressed();
                            },
                            child: Text("Reject"),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  width: 1.6,
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          child: MaterialButton(
                            onPressed: () {
                              _onApprovePressed();
                            },
                            child: Text("Approve"),
                            color: Colors.green[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

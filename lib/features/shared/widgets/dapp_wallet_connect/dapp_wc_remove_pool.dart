import 'package:flutter/material.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'connect_response_model.dart';

class DAppWalletConnectRemovePool extends StatelessWidget {
  final BuildContext context;
  final String owner;
  final String spender;
  final ConnectResponse connectResponse;
  final dynamic approveRemovePool;

  DAppWalletConnectRemovePool(this.context, this.connectResponse, this.owner,
      this.spender, this.approveRemovePool);

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
          title: "Signing",
          body: Container(
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Sign this message?",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Message",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 40, right: 40),
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
                                left: 20.0, right: 20, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Owner: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 15),
                                  child: Text(
                                    owner,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Spender: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 5),
                                    child: Text(
                                      spender,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                width: 1.5,
                                color: Colors.black,
                                style: BorderStyle.solid)),
                        child: MaterialButton(
                            onPressed: () {
                              _onCancelPressed();
                            },
                            child: Text("Cancel"),
                            color: Colors.white),
                      ),
                      SizedBox(width: 30),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                width: 1.6,
                                color: Colors.black,
                                style: BorderStyle.solid)),
                        child: MaterialButton(
                            onPressed: () {
                              _onSignPressed();
                            },
                            child: Text("Sign"),
                            color: Colors.green[300]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onSignPressed() async {
    this.approveRemovePool;
    Navigator.pop(context);
  }

  void _onCancelPressed() async {}
}

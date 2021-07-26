import 'package:flutter/material.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallet_connect_flutter/wallet_connect_flutter.dart';

import 'connect_response_model.dart';
import 'dapp_wc_home.dart';

class DAppWalletConnect extends StatelessWidget {
  final BuildContext context;
  final String walletAddress;
  final ConnectResponse connectResponse;
  final WalletConnectFlutter conn;
  final dynamic approveSession;
  DAppWalletConnect(
    this.context,
    this.walletAddress,
    this.connectResponse,
    this.conn,
    this.approveSession,
  );

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
        builder: (_) {
          return buildConnectDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildConnectDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: MyScaffold(
          title: "Connect DApp",
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Hero(
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFE0E0E0),
                      radius: 35,
                      backgroundImage:
                          NetworkImage('${connectResponse.meta.icons[2]}'),
                    ),
                    tag: "walletconnect dapp",
                  ),
                ),
                Text(
                  "${connectResponse.meta.name} would like to\n connect to your wallet",
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(connectResponse.meta.url),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Text("View your wallet balance and activity")
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Text("View your wallet balance and activity")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: MaterialButton(
                    onPressed: () {
                      _onConnectPressed();
                    },
                    child: Text("Connect"),
                    color: Colors.green[300],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onConnectPressed() async {
    this.approveSession;
    Navigator.pop(context);
    await DAppWalletConnectHome(
      context,
      connectResponse,
      walletAddress,
      conn,
    ).showBottomSheet();
  }
}

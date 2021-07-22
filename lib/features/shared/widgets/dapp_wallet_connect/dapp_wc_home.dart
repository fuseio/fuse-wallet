import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/dapp_wallet_connect/connect_response_model.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallet_connect_flutter/wallet_connect_flutter.dart';

class DAppWalletConnectHome extends StatelessWidget {
  final BuildContext context;
  final ConnectResponse connectResponse;
  final String wa;
  final WalletConnectFlutter conn;

  DAppWalletConnectHome(this.context, this.connectResponse, this.wa, this.conn);

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
        builder: (_) => buildHomeDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildHomeDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: MyScaffold(
          title: "Connect DApp",
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFE0E0E0),
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/anom.png'),
                    ),
                    tag: "walletconnect dapp",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text("${connectResponse.meta.url}"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                        "You are connected to ${connectResponse.meta.name}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _onDisconnectedPressed();
                        },
                        child: Text("Disconnect"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.green[300]))),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _onDisconnectedPressed() async {
    await conn.killSession();
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

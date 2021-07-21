import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/barcode_scanner.dart';

import 'dart:core';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DAppWalletConnect extends StatelessWidget {
  final BuildContext context;
  final String walletAddress;

  DAppWalletConnect(this.context, this.walletAddress);

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
        builder: (_) => buildConnectDialog());
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
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/anom.png'),
                    ),
                    tag: "contactSent",
                  ),
                ),
                Text("DApp Name would like to\n connect to your wallet"),
                TextButton(
                  onPressed: () {},
                  child: Text("http://app.xxxx.com"),
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
                ElevatedButton(
                    onPressed: () {
                      _onConnectPressed();
                    },
                    child: Text("Connect"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.green[300]))),
              ],
            ),
          )),
    );
  }

  Future<bool> _onConnectPressed() async {
    return true;
  }
}

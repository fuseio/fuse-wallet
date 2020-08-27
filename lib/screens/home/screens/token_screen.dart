import 'package:flutter/material.dart';
import 'package:straitsx/screens/home/widgets/token_header.dart';
import 'package:straitsx/screens/home/widgets/transaction_tile.dart';
import 'package:straitsx/widgets/my_app_bar.dart';
import 'package:straitsx/generated/i18n.dart';
import 'package:straitsx/models/tokens/token.dart';

class TokenScreen extends StatelessWidget {
  TokenScreen({Key key, this.token, this.tokenPrice}) : super(key: key);
  final String tokenPrice;
  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: MyAppBar(
            height: 170.0,
            child: TokenHeader(token: token, tokenPrice: tokenPrice),
            backgroundColor: Colors.white),
        drawerEdgeDragWidth: 0,
        body: Column(children: <Widget>[
          Expanded(child: ListView(children: [TransfersList(token: token)])),
        ]));
  }
}

class TransfersList extends StatelessWidget {
  final Token token;
  TransfersList({this.token});
  @override
  Widget build(BuildContext context) {
    final list = token?.transactions?.list?.reversed?.toList() ?? [];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
              child: Text(I18n.of(context).transactions,
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal))),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: list?.length,
              itemBuilder: (BuildContext ctxt, int index) =>
                  TransactionTile(transfer: list[index], token: token))
        ]);
  }
}

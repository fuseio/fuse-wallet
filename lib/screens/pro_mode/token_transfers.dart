import 'package:fusecash/screens/cash_home/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/screens/pro_mode/pro_token_header.dart';
import 'package:fusecash/widgets/my_app_bar.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';

class TokenTransfersScreen extends StatelessWidget {
  TokenTransfersScreen({Key key, this.token}) : super(key: key);
  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: MyAppBar(
            height: MediaQuery.of(context).size.height * .21,
            child: ProTokenHeader(token: token),
            backgroundColor: Colors.white),
        drawerEdgeDragWidth: 0,
        body: Column(children: <Widget>[
          Expanded(child: ListView(children: [TransfersList(token: token)])),
        ]));
  }
}

class TransfersList extends StatelessWidget {
  TransfersList({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
              child: Text(I18n.of(context).transactions,
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal))),
          ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(left: 15, right: 15),
              children: [
                ...token.transactions.list.reversed
                    .map((Transaction transaction) =>
                        TransactionTile(transfer: transaction))
                    .toList()
              ])
        ]);
  }
}

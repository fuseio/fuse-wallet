import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/screens/pro_mode/pro_token_header.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/transaction_row.dart';
import 'package:fusecash/widgets/my_app_bar.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/pro/views/pro_wallet.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/utils/addresses.dart';

class TokenTransfersScreen extends StatelessWidget {
  TokenTransfersScreen({Key key, this.token}) : super(key: key);
  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: MyAppBar(child: ProTokenHeader(token: token), backgroundColor: Colors.red),
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
              padding: EdgeInsets.only(left: 15, top: 27, bottom: 8),
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
                ...token.transactions.list
                    .map((Transaction transaction) =>
                        _TransferRow(transaction: transaction, token: token))
                    .toList()
              ])
        ]);
  }
}

class _TransferRow extends StatelessWidget {
  _TransferRow({this.transaction, this.token});
  final Token token;
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    Transfer transfer = transaction as Transfer;

    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: NetworkImage(
                                  token.imageUrl,
                                ),
                              ),
                              tag: transfer.txHash,
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(token.name,
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: <Widget>[
                                new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                      text: deduceSign(transfer) +
                                          formatValue(
                                              transfer.value, token.decimals),
                                      style: new TextStyle(
                                          color: deduceColor(transfer),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text: " ${token.symbol}",
                                      style: new TextStyle(
                                          color: deduceColor(transfer),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ])),
                                transfer.isFailed()
                                    ? Positioned(
                                        left: -25,
                                        child: SvgPicture.asset(
                                            'assets/images/failed.svg'),
                                      )
                                    : SizedBox.shrink(),
                                Positioned(
                                    bottom: -20,
                                    child: (transfer.isPending() &&
                                            !transfer.isGenerateWallet() &&
                                            !transfer.isJoinCommunity())
                                        ? Padding(
                                            child: Text(
                                                I18n.of(context).pending,
                                                style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 10)),
                                            padding: EdgeInsets.only(top: 10))
                                        : SizedBox.shrink())
                              ],
                            )
                          ],
                        )
                      ]))
            ],
          )),
    );
  }
}

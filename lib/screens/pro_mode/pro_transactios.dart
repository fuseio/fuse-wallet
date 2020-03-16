import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/pro/views/pro_wallet.dart';
// import 'package:fusecash/utils/format.dart';

class ProTransactios extends StatelessWidget {
  ProTransactios({this.viewModel});
  final ProWalletViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 27, bottom: 8),
              child: Text(I18n.of(context).assets_and_contracts,
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal))),
          ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: [
                ...viewModel.tokens.reversed
                    .map((Token token) => _TokenRow(
                          token: token,
                        ))
                    .toList()
              ])
        ]);
  }
}

class _TokenRow extends StatelessWidget {
  _TokenRow({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
      child: ListTile(
          title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              flex: 10,
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
                          tag: token.name,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    flex: 10,
                    child: Text(token.name,
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 15)),
                  ),
                ],
              )),
          Flexible(
              flex: 3,
              child: Container(
                width: 100,
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
                                    text:
                                        '\$' + token.amount.toStringAsFixed(3),
                                    style: new TextStyle(
                                        // color: deduceColor(transfer),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.secondary)),
                                // new TextSpan(
                                //     text: " ${token.symbol}",
                                //     style: new TextStyle(
                                //         // color: deduceColor(transfer),
                                //         fontSize: 10.0,
                                //         fontWeight: FontWeight.normal,
                                //         color: Theme.of(context).primaryColor)),
                              ])),
                              Positioned(
                                  bottom: -20,
                                  child: Padding(
                                      child: Text(token.amount.toStringAsFixed(3) + ' ' + token.symbol,
                                          style: TextStyle(
                                              color: Color(0xFF8D8D8D),
                                              fontSize: 10)),
                                      padding: EdgeInsets.only(top: 10)))
                            ],
                          )
                        ],
                      )
                    ]),
              ))
        ],
      )),
    );
  }
}

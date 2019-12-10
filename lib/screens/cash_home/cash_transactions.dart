import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:fusecash/models/token.dart';


class CashTransactios extends StatefulWidget {
  CashTransactios({@required this.viewModel});

  final CashWalletViewModel viewModel;
  @override
  createState() => new CashTransactiosState();
}

String deduceSign(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return '-';
  } else {
    return '+';
  }
}

Color deduceColor(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return Color(0xFFFF0000);
  } else {
    return Color(0xFF00BE66);
  }
}

class CashTransactiosState extends State<CashTransactios> {
  CashTransactiosState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 8),
                          child: Text("Transactions",
                              style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal))),
                  ListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      children: this.widget.viewModel.tokenTransfers
                          .map((transfer) =>
                              _TransactionListItem(transfer, this.widget.viewModel.token))
                          .toList())
                ],
              );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transfer _transfer;
  final Token _token;

  _TransactionListItem(this._transfer, this._token);

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: new BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            child: ListTile(
              title:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Maria  Toman",
                  style: TextStyle(color: Color(0xFF333333), fontSize: 18)),
                  Text("For coffee",
                  style: TextStyle(color: Color(0xFF8D8D8D), fontSize: 15))
                ],
              )
               ,
              leading: Stack(
                children: <Widget>[
                  CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        child: Image.asset('assets/images/pep.png',
                            width: 59.0),
                      ),
                  
                ],
              ),
              trailing: Container(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        deduceSign(_transfer) + (_transfer.value / BigInt.from(pow(10, _token.decimals))).toString(),
                        style: TextStyle(
                            color: deduceColor(_transfer),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      " ${_token.symbol}",
                      style: TextStyle(
                          color: deduceColor(_transfer),
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              ),
            ));
  }
}
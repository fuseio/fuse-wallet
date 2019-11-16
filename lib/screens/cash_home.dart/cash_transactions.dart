import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class CashTransactios extends StatefulWidget {
  CashTransactios();

  @override
  createState() => new CashTransactiosState();
}

class CashTransactiosState extends State<CashTransactios> {
  CashTransactiosState();

  List<Transaction> transactions = new List<Transaction>();
  
  @override
  void initState() {
    super.initState();

    transactions.add(new Transaction(10, "\$", ""));
    transactions.add(new Transaction(10, "\$", ""));
    transactions.add(new Transaction(10, "\$", ""));
    transactions.add(new Transaction(10, "\$", ""));
    transactions.add(new Transaction(10, "\$", ""));
    transactions.add(new Transaction(10, "\$", ""));
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
                      children: transactions
                          .map((transaction) =>
                              _TransactionListItem(transaction))
                          .toList())
                ],
              );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction _transaction;

  _TransactionListItem(this._transaction);

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
                        _transaction.amount.toString(),
                        style: TextStyle(
                            color: Color(0xFF00BE66),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "\$",
                      style: TextStyle(
                          color: Color(0xFF00BE66),
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

class Transaction {
  final double amount;
  final String symbol;
  final String date;

  Transaction(this.amount, this.symbol, this.date);
}
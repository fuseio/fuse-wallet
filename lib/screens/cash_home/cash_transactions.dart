import 'package:flutter/material.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/transactions/transfer.dart';
import 'dart:core';
import 'package:peepl/models/views/cash_wallet.dart';
import 'package:peepl/screens/cash_home/transaction_row.dart';
import 'package:peepl/utils/transaction_row.dart';

class CashTransactios extends StatefulWidget {
  CashTransactios({@required this.viewModel});

  final CashWalletViewModel viewModel;
  @override
  createState() => new CashTransactionsState();
}

class CashTransactionsState extends State<CashTransactios> {
  CashTransactionsState();

  @override
  void initState() {
    super.initState();
  }

  renderTrasfers() {
    bool isWalletCreated = 'created' == this.widget.viewModel.walletStatus;
    Transfer generateWallet = new Transfer(
        type: 'RECEIVE',
        text: !isWalletCreated ? I18n.of(context).generating_wallet : I18n.of(context).generated_wallet,
        status: !isWalletCreated ? 'PENDING' : 'CONFIRMED',
        jobId: 'generateWallet');
    List<TransactionListItem> transfers = [
      ...this
          .widget
          .viewModel
          .transactions
          .list
          .reversed
          .map((transfer) => TransactionListItem(
              transfer,
              getContact(
                  transfer,
                  this.widget.viewModel.reverseContacts,
                  this.widget.viewModel.contacts,
                  this.widget.viewModel.countryCode),
              this.widget.viewModel))
          .toList(),
      TransactionListItem(generateWallet, null, this.widget.viewModel),
    ];
    return transfers;
  }

  @override
  Widget build(BuildContext _context) {
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
              children: renderTrasfers())
        ]);
  }
}

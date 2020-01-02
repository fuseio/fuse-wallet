import 'package:flutter/material.dart';
import 'dart:core';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/utils/format.dart';
import 'dart:math' as math;

class CashTransactios extends StatefulWidget {
  CashTransactios({@required this.viewModel});

  final CashWalletViewModel viewModel;
  @override
  createState() => new CashTransactionsState();
}

String deduceSign(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return '-';
  } else {
    return '+';
  }
}

String deducePhoneNumber(
    Transfer transfer, Map<String, String> reverseContacts) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  return formatAddress(accountAddress);
}

Contact getContact(Transfer transfer, Map<String, String> reverseContacts,
    List<Contact> contacts, String countryCode) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (accountAddress == null) {
    return null;
  }
  if (reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String phoneNumber = reverseContacts[accountAddress.toLowerCase()];
    if (contacts == null) return null;
    for (Contact contact in contacts) {
      for (Item contactPhoneNumber in contact.phones.toList()) {
        if (formatPhoneNumber(contactPhoneNumber.value, countryCode) ==
            phoneNumber) {
          return contact;
        }
      }
    }
  }
  return null;
}

Color deduceColor(Transfer transfer) {
  if (transfer.type == 'SEND') {
    return Color(0xFFFF0000);
  } else {
    return Color(0xFF00BE66);
  }
}

class CashTransactionsState extends State<CashTransactios> {
  CashTransactionsState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    List<_TransactionListItem> transfers = this
        .widget
        .viewModel
        .transactions
        .list
        .reversed
        .map((transfer) => _TransactionListItem(
            transfer,
            getContact(
                transfer,
                this.widget.viewModel.reverseContacts,
                this.widget.viewModel.contacts,
                this.widget.viewModel.countryCode),
            this.widget.viewModel))
        .toList();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
              child: Text("Transactions",
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal))),
          ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: transfers)
        ]);
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Contact _contact;
  final CashWalletViewModel _vm;

  _TransactionListItem(
    this._transaction,
    this._contact,
    this._vm,
  );

  @override
  Widget build(BuildContext context) {
    Transfer transfer = _transaction as Transfer;
    List<Widget> rightColumn = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              deduceSign(_transaction) +
                  formatValue(transfer.value, _vm.token.decimals),
              style: TextStyle(
                  color: deduceColor(_transaction),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            " ${_vm.token.symbol}",
            style: TextStyle(
                color: deduceColor(_transaction),
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          )
        ],
      )
    ];

    if (_transaction.status == 'PENDING') {
      rightColumn.add(Padding(
          child: Text("PENDING",
              style: TextStyle(color: Color(0xFF8D8D8D), fontSize: 10)),
          padding: EdgeInsets.only(top: 10)));
    }

    return Container(
        decoration: new BoxDecoration(
            border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  _transaction.text != null ? _transaction.text :
                  _contact != null
                      ? _contact.displayName
                      : deducePhoneNumber(_transaction, _vm.reverseContacts),
                  style: TextStyle(color: Color(0xFF333333), fontSize: 18))
            ],
          ),
          leading: Stack(
            children: <Widget>[
              Hero(
                child: CircleAvatar(
                  backgroundColor: Color(0xFFE0E0E0),
                  radius: 25,
                  backgroundImage: _contact?.avatar != null
                      ? MemoryImage(_contact.avatar)
                      : new AssetImage('assets/images/anom.png'),
                ),
                tag: _transaction.status == 'PENDING'
                    ? "contactSent"
                    : "transaction" + _transaction.txHash,
              ),
              _transaction.status == 'PENDING'
                  ? Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xFF49D88D).withOpacity(0),
                        strokeWidth: 4, //backgroundColor: Color(0xFFb8e3a6),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF49D88D).withOpacity(1)),
                      ))
                  : SizedBox.shrink()
            ],
          ),
          trailing: Container(
            width: 120,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: rightColumn),
            padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/TransactionDetails');
          },
        ));
  }
}

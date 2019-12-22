import 'package:flutter/material.dart';
import 'dart:core';
import 'package:fusecash/models/views/cash_wallet.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/utils/format.dart';

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

String deducePhoneNumber(
    Transfer transfer, Map<String, String> reverseContacts) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  return formatAddress(accountAddress);
}


Contact getContact(Transfer transfer, CashWalletViewModel vm) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (vm.reverseContacts.containsKey(accountAddress.toLowerCase())) {
    String phoneNumber = vm.reverseContacts[accountAddress.toLowerCase()];
    if (vm.contacts == null) return null;
    for (Contact contact in vm.contacts) {
      for (Item contactPhoneNumber in contact.phones.toList()) {
        if (formatPhoneNumber(contactPhoneNumber.value, vm.countryCode) ==
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

class CashTransactiosState extends State<CashTransactios> {
  CashTransactiosState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    List<_TransactionListItem> transfers = this
            .widget
            .viewModel
            .pendingTransfers
            .map((transfer) => _TransactionListItem(
                transfer,
                getContact(transfer, this.widget.viewModel),
                this.widget.viewModel,
                true))
            .toList() +
        this
            .widget
            .viewModel
            .tokenTransfers
            .map((transfer) => _TransactionListItem(
                transfer,
                getContact(transfer, this.widget.viewModel),
                this.widget.viewModel,
                false))
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
  final Transfer _transfer;
  final Contact _contact;
  final CashWalletViewModel _vm;
  final bool isPending;

  _TransactionListItem(this._transfer, this._contact, this._vm, this.isPending);

  @override
  Widget build(BuildContext context) {
    List<Widget> rightColumn = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              deduceSign(_transfer) + formatValue(_transfer.value, _vm.token.decimals),
              style: TextStyle(
                  color: deduceColor(_transfer),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            " ${_vm.token.symbol}",
            style: TextStyle(
                color: deduceColor(_transfer),
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          )
        ],
      )
    ];

    if (isPending) {
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
                  _contact != null
                      ? _contact.displayName
                      : deducePhoneNumber(_transfer, _vm.reverseContacts),
                  style: TextStyle(color: Color(0xFF333333), fontSize: 18))
            ],
          ),
          leading: Stack(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 25,
                backgroundImage: _contact?.avatar != null ? MemoryImage(_contact.avatar) : new AssetImage('assets/images/anom.png'),
              ),
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
        ));
  }
}
import 'package:flutter/material.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/transfer.dart';
import 'dart:core';
import 'package:paywise/models/views/cash_wallet.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:paywise/screens/cash_home/transaction_item.dart';
import 'package:paywise/utils/phone.dart';
import 'package:paywise/utils/format.dart';

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

String deducePhoneNumber(Transfer transfer, Map<String, String> reverseContacts,
    {bool format = true}) {
  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  if (reverseContacts.containsKey(accountAddress)) {
    return reverseContacts[accountAddress];
  }
  if (format) {
    return formatAddress(accountAddress);
  } else {
    return accountAddress;
  }
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
  if (transfer.isFailed()) {
    return Color(0xFFE0E0E0);
  } else {
    if (transfer.type == 'SEND') {
      return Color(0xFFFF0000);
    } else {
      return Color(0xFF00BE66);
    }
  }
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
        status: !isWalletCreated ? I18n.of(context).pending : I18n.of(context).confirmed,
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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: renderTrasfers())
        ]);
  }
}

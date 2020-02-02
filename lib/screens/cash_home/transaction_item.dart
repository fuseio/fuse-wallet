import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/business.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/models/views/cash_wallet.dart';
import 'package:paywise/screens/buy/business.dart';
import 'package:paywise/screens/cash_home/transaction_details.dart';
import 'package:paywise/utils/format.dart';
import 'package:paywise/utils/phone.dart';

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

dynamic getImage(Transfer transfer, Contact contact, CashWalletViewModel vm) {
  if (transfer.isJoinCommunity()) {
    return new AssetImage(
      'assets/images/join_community.png',
    );
  } else if (transfer.isGenerateWallet()) {
    return new AssetImage(
      'assets/images/generate_wallet.png',
    );
  } else if (transfer.isJoinBonus()) {
    return new AssetImage(
      'assets/images/join.png',
    );
  } else if (contact?.avatar != null) {
    return new MemoryImage(contact.avatar);
  }

  String accountAddress = transfer.type == 'SEND' ? transfer.to : transfer.from;
  Business business = vm.businesses.firstWhere(
      (business) => business.account == accountAddress,
      orElse: () => null);
  if (business != null) {
    return NetworkImage(getImageUrl(business, vm.communityAddress));
  }
  return new AssetImage('assets/images/anom.png');
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

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Contact _contact;
  final CashWalletViewModel _vm;

  TransactionListItem(
    this._transaction,
    this._contact,
    this._vm,
  );

  @override
  Widget build(BuildContext context) {
    Transfer transfer = _transaction as Transfer;
    List<Widget> rightColumn = <Widget>[
      transfer.isGenerateWallet() || transfer.isJoinCommunity()
          ? SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RichText(
                    text: new TextSpan(children: <TextSpan>[
                  new TextSpan(
                      text: deduceSign(_transaction) +
                          formatValue(transfer.value, _vm.token.decimals),
                      style: new TextStyle(
                          color: deduceColor(_transaction),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  new TextSpan(
                      text: " ${_vm.token.symbol}",
                      style: new TextStyle(
                          color: deduceColor(_transaction),
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal)),
                ]))
              ],
            )
    ];

    if (_transaction.isPending() &&
        !transfer.isGenerateWallet() &&
        !transfer.isJoinCommunity()) {
      rightColumn.add(Padding(
          child: Text(I18n.of(context).pending,
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
                  transfer.isJoinBonus()
                      ? I18n.of(context).join_bonus
                      : (transfer.receiverName != null &&
                              transfer.receiverName != '')
                          ? transfer.receiverName
                          : _transaction.text != null
                              ? _transaction.text
                              : _contact != null
                                  ? _contact.displayName
                                  : deducePhoneNumber(
                                      _transaction, _vm.reverseContacts),
                  style: TextStyle(color: Color(0xFF333333), fontSize: 15))
            ],
          ),
          leading: Stack(
            children: <Widget>[
              Hero(
                child: CircleAvatar(
                  backgroundColor: Color(0xFFE0E0E0),
                  radius: 27,
                  backgroundImage: getImage(transfer, _contact, _vm),
                ),
                tag: transfer.isGenerateWallet()
                    ? ''
                    : _transaction.isPending()
                        ? "contactSent"
                        : "transaction" + _transaction.txHash,
              ),
              _transaction.isPending()
                  ? Container(
                      width: 54,
                      height: 54,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xFF49D88D).withOpacity(0),
                        strokeWidth: 3, //backgroundColor: Color(0xFFb8e3a6),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF49D88D).withOpacity(1)),
                      ))
                  : SizedBox.shrink()
            ],
          ),
          trailing: Container(
            width: 100,
            child: Column(
                mainAxisAlignment: _transaction.isPending()
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: _transaction.isPending()
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
                children: transfer.isGenerateWallet() ? [] : rightColumn),
            // padding: EdgeInsets.only(top: 10, bottom: 0, left: 0, right: 10),
          ),
          onTap: () {
            if (!transfer.isGenerateWallet() || !transfer.isJoinCommunity()) {
              Navigator.pushNamed(context, '/TransactionDetails',
                  arguments: TransactionDetailArguments(
                    transfer: transfer,
                    contact: _contact,
                    reverseContacts: _vm.reverseContacts,
                    symbol: _vm.token.symbol,
                    amount: [
                      Text(
                        deduceSign(_transaction) +
                            formatValue(transfer.value, _vm.token.decimals),
                        style: TextStyle(
                            color: deduceColor(_transaction),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${_vm.token.symbol}",
                        style: TextStyle(
                            color: deduceColor(_transaction),
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ));
            } else {
              return;
            }
          },
        ));
  }
}

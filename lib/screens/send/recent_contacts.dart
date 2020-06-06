import 'package:bit2c/screens/send/contact_tile.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bit2c/generated/i18n.dart';
import 'package:bit2c/models/app_state.dart';
import 'package:bit2c/models/transactions/transaction.dart';
import 'package:bit2c/models/transactions/transfer.dart';
import 'package:bit2c/models/views/contacts.dart';
import 'package:bit2c/screens/send/send_amount.dart';
import 'package:bit2c/screens/send/send_amount_arguments.dart';
import 'package:bit2c/utils/send.dart';
import 'package:bit2c/utils/transaction_row.dart';

class RecentContacts extends StatelessWidget {
  final int numToShow;
  const RecentContacts({Key key, this.numToShow = 3}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        List<Widget> listItems = List();
        Map<String, Transaction> uniqueValues = {};
        final List<Transaction> sorted = new List<Transaction>.from(
                viewModel.transactions.list.toSet().toList())
            .where((t) => t.type == 'SEND' && t.isConfirmed())
            .toList();

        for (Transaction item in sorted) {
          final Contact contact = getContact(item, viewModel.reverseContacts,
              viewModel.contacts, viewModel.countryCode);
          var a = contact != null
              ? contact.displayName
              : deducePhoneNumber(item, viewModel.reverseContacts,
                  businesses: viewModel.businesses);
          uniqueValues[a] = item;
        }
        List test = uniqueValues.values.toList().reversed.toList();
        List uniqueList =
            test.length > numToShow ? test.sublist(0, numToShow) : test;

        for (int i = 0; i < uniqueList.length; i++) {
          final Transfer transfer = uniqueList[i];
          final Contact contact = getContact(
              transfer,
              viewModel.reverseContacts,
              viewModel.contacts,
              viewModel.countryCode);
          final String displayName = contact != null
              ? contact.displayName
              : deducePhoneNumber(transfer, viewModel.reverseContacts,
                  businesses: viewModel.businesses);
          dynamic image =
              getContactImage(transfer, contact, viewModel.businesses);
          String phoneNumber = viewModel.reverseContacts[transfer.to.toLowerCase()] ?? '';
          listItems.add(ContactTile(
              image: image,
              displayName: displayName,
              phoneNumber: phoneNumber,
              trailing: Text(
                phoneNumber,
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                if (transfer.to.toLowerCase() ==
                    viewModel.community.homeBridgeAddress.toLowerCase()) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SendAmountScreen(
                              pageArgs: SendAmountArguments(
                                  avatar: AssetImage(
                                    'assets/images/ethereume_icon.png',
                                  ),
                                  name: 'Send to ethereum',
                                  feePlugin: viewModel
                                      .community.plugins.bridgeToForeign,
                                  sendType: viewModel.isProMode
                                      ? SendType.ETHEREUM_ADDRESS
                                      : SendType.FUSE_ADDRESS,
                                  accountAddress: transfer.to))));
                  return;
                }
                if (contact == null) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SendAmountScreen(
                              pageArgs: SendAmountArguments(
                                  sendType: viewModel.isProMode
                                      ? SendType.ETHEREUM_ADDRESS
                                      : SendType.FUSE_ADDRESS,
                                  accountAddress: transfer.to,
                                  name: displayName,
                                  avatar: image))));
                } else {
                  sendToContact(context, viewModel, displayName, '',
                      avatar: image, address: transfer.to);
                }
              }));
        }

        if (listItems.isNotEmpty) {
          listItems.insert(
              0,
              Container(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
                  child: Text(I18n.of(context).recent,
                      style: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal))));
        }
        return SliverList(
          delegate: SliverChildListDelegate(listItems),
        );
      },
    );
  }
}

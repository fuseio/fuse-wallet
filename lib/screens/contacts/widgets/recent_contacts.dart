import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:straitsx/generated/i18n.dart';
import 'package:straitsx/models/app_state.dart';
import 'package:straitsx/models/transactions/transaction.dart';
import 'package:straitsx/models/transactions/transfer.dart';
import 'package:straitsx/models/views/contacts.dart';
import 'package:straitsx/screens/contacts/widgets/contact_tile.dart';
import 'package:straitsx/utils/send.dart';
import 'package:straitsx/utils/transaction_util.dart';

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
          dynamic image = getContactImage(transfer, contact,
              businesses: viewModel.businesses);
          String phoneNumber =
              viewModel.reverseContacts[transfer.to.toLowerCase()] ?? '';
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
                  navigateToSendAmountScreen(transfer.to, 'ethereum', null,
                      avatar: AssetImage(
                        'assets/images/ethereume_icon.png',
                      ));
                  return;
                }
                if (contact == null) {
                  navigateToSendAmountScreen(transfer.to, displayName, null,
                      avatar: image);
                } else {
                  sendToContact(context, displayName, '',
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

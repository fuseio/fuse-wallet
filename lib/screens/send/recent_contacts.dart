import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/transactions/transaction.dart';
import 'package:digitalrand/models/transactions/transfer.dart';
import 'package:digitalrand/models/views/contacts.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:digitalrand/utils/send.dart';
import 'package:digitalrand/utils/transaction_row.dart';

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
          final String displatName = contact != null
              ? contact.displayName
              : deducePhoneNumber(transfer, viewModel.reverseContacts,
                  businesses: viewModel.businesses);
          dynamic image =
              getContactImage(transfer, contact, viewModel.businesses);
          listItems.add(
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                decoration: new BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFE0E0E0),
                    radius: 25,
                    backgroundImage: image,
                  ),
                  title: Text(
                    displatName,
                    style: TextStyle(fontSize: 16),
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
                                      name: displatName,
                                      avatar: image))));
                    } else {
                      sendToContact(context, viewModel, displatName, '',
                          avatar: image, address: transfer.to);
                    }
                  },
                ),
              ),
            ),
          );
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

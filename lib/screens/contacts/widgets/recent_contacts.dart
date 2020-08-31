import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/models/views/contacts.dart';
import 'package:esol/screens/contacts/send_amount_arguments.dart';
import 'package:esol/screens/contacts/widgets/contact_tile.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/utils/send.dart';
import 'package:esol/utils/transaction_util.dart';

class RecentContacts extends StatelessWidget {
  final int numofRecentToShow;
  const RecentContacts({Key key, this.numofRecentToShow = 3}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
      distinct: true,
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        final List<Transfer> sorted = new List<Transfer>.from(
                viewModel.transactions.list.toSet().toList())
            .where((t) => t.type == 'SEND' && t.isConfirmed())
            .toList();

        final Map<String, Transfer> uniqueValues =
            Map<String, Transfer>.fromEntries(
                sorted.map((e) => new MapEntry(e.to, e)));

        final List<Transfer> uniqueList =
            uniqueValues.length > numofRecentToShow
                ? uniqueValues.values.toList().sublist(0, numofRecentToShow)
                : uniqueValues.values.toList();

        final List<Widget> listItems = uniqueList
            .map((Transfer transfer) {
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
              return ContactTile(
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
                      ExtendedNavigator.root.push(Routes.sendAmountScreen,
                          arguments: SendAmountScreenArguments(
                              pageArgs: SendAmountArguments(
                                  name: 'Ethereum',
                                  accountAddress: transfer.to,
                                  avatar: AssetImage(
                                    'assets/images/ethereume_icon.png',
                                  ))));
                      return;
                    }
                    if (contact == null) {
                      ExtendedNavigator.root.push(Routes.sendAmountScreen,
                          arguments: SendAmountScreenArguments(
                              pageArgs: SendAmountArguments(
                                  name: displayName,
                                  accountAddress: transfer.to,
                                  avatar: image)));
                    } else {
                      sendToContact(
                          ExtendedNavigator.named('contactsRouter').context,
                          displayName,
                          '',
                          avatar: image,
                          address: transfer.to);
                    }
                  });
            })
            .cast<Widget>()
            .toList();

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

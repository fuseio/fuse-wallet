import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/features/contacts/widgets/contact_tile.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/recent_contacts.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/send.dart';
import 'package:fusecash/utils/transfer.dart';

class RecentContacts extends StatelessWidget {
  final int numofRecentToShow;
  final Token token;
  const RecentContacts({
    Key key,
    this.numofRecentToShow = 3,
    this.token,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, RecentContactsViewModel>(
      distinct: true,
      converter: RecentContactsViewModel.fromStore,
      builder: (_, viewModel) {
        final Map<String, WalletAction> uniqueValues =
            Map<String, WalletAction>.fromEntries(
          viewModel.walletActions.map(
            (e) => MapEntry(e.getRecipient(), e),
          ),
        );

        final List<WalletAction> uniqueList =
            uniqueValues.length > numofRecentToShow
                ? uniqueValues.values.toList().sublist(0, numofRecentToShow)
                : uniqueValues.values.toList();

        final List<Widget> listItems = uniqueList
            .map((WalletAction transfer) {
              final Contact? contact = getContact(
                transfer.getRecipient(),
                viewModel.reverseContacts,
                viewModel.contacts,
                viewModel.countryCode,
              );
              final String displayName = (contact?.displayName ??
                  deducePhoneNumber(
                    transfer.getRecipient(),
                    viewModel.reverseContacts,
                  ))!;
              dynamic image = ImageUrl.getContactImage(
                contact,
              );
              String phoneNumber =
                  viewModel.reverseContacts[transfer.getRecipient()] ?? '';
              return ContactTile(
                image: image,
                displayName: displayName,
                // phoneNumber: phoneNumber,
                trailing: Text(
                  phoneNumber,
                  style: TextStyle(fontSize: 13),
                ),
                onTap: () {
                  if (contact == null) {
                    // ExtendedNavigator.root.pushSendAmountScreen(
                    //   pageArgs: SendFlowArguments(
                    //     name: displayName,
                    //     accountAddress: transfer.getRecipient(),
                    //     avatar: image,
                    //     tokenToSend: token,
                    //   ),
                    // );
                  } else {
                    // sendToContact(
                    //   ExtendedNavigator.named('contactsRouter').context,
                    //   displayName,
                    //   '',
                    //   avatar: image,
                    //   address: transfer.getRecipient(),
                    //   tokenToSend: token,
                    // );
                  }
                },
              );
            })
            .cast<Widget>()
            .toList();

        if (listItems.isNotEmpty) {
          listItems.insert(
              0,
              Container(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
                  child: Text(I10n.of(context).recent,
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

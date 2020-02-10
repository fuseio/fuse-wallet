import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/business.dart';
import 'package:paywise/models/community.dart';
import 'package:paywise/models/token.dart';
import 'package:paywise/models/transactions.dart';
import 'package:paywise/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final List<Contact> contacts;
  final Token token;
  final bool isContactsSynced;
  final Function(List<Contact>) syncContacts;
  final Transactions transactions;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final Function() syncContactsRejected;
  final List<Business> businesses;

  ContactsViewModel(
      {this.contacts,
      this.token,
      this.syncContacts,
      this.isContactsSynced,
      this.transactions,
      this.reverseContacts,
      this.countryCode,
      this.businesses,
      this.syncContactsRejected});

  static ContactsViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres];
    return ContactsViewModel(
        businesses: community?.businesses ?? [],
        isContactsSynced: store.state.userState.isContactsSynced,
        contacts: store.state.userState.contacts ?? [],
        token: community?.token,
        transactions: community?.transactions,
        reverseContacts: store.state.userState.reverseContacts,
        countryCode: store.state.userState.countryCode,
        syncContacts: (List<Contact> contacts) {
          store.dispatch(syncContactsCall(contacts));
        },
        syncContactsRejected: () {
          store.dispatch(new SyncContactsRejected());
        });
  }

  @override
  List<Object> get props => [
    contacts,
    token,
    isContactsSynced,
    transactions,
    reverseContacts,
    countryCode,
    businesses
  ];
}

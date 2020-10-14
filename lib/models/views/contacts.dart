import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:straitsx/models/app_state.dart';
import 'package:straitsx/models/community/business.dart';
import 'package:straitsx/models/community/community.dart';
import 'package:straitsx/models/tokens/token.dart';
import 'package:straitsx/models/transactions/transactions.dart';
import 'package:straitsx/redux/actions/cash_wallet_actions.dart';
import 'package:straitsx/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final List<Contact> contacts;
  final Function(List<Contact>) syncContacts;
  final Transactions transactions;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final String isoCode;
  final Function() syncContactsRejected;
  final List<Business> businesses;
  final Function(String eventName) trackCall;
  final Function(Map<String, dynamic> traits) idenyifyCall;
  final Community community;

  ContactsViewModel(
      {this.contacts,
      this.syncContacts,
      this.transactions,
      this.reverseContacts,
      this.countryCode,
      this.community,
      this.isoCode,
      this.businesses,
      this.syncContactsRejected,
      this.trackCall,
      this.idenyifyCall});

  static ContactsViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres];
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return ContactsViewModel(
        isoCode: store.state.userState.isoCode,
        businesses: community?.businesses ?? [],
        contacts: store.state.userState?.contacts ?? [],
        community: community,
        transactions: token?.transactions,
        reverseContacts: store.state.userState.reverseContacts,
        countryCode: store.state.userState.countryCode,
        syncContacts: (List<Contact> contacts) {
          store.dispatch(syncContactsCall(contacts));
        },
        syncContactsRejected: () {
          store.dispatch(new SyncContactsRejected());
        },
        trackCall: (String eventName) {
          store.dispatch(segmentTrackCall(eventName));
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }

  @override
  List<Object> get props => [
        contacts,
        transactions,
        reverseContacts,
        countryCode,
        businesses,
        isoCode,
        community
      ];
}

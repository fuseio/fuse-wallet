import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final List<Contact> contacts;
  final Function() syncContacts;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final String isoCode;
  final Function() syncContactsRejected;
  final List<Business> businesses;
  final Function(String eventName) trackCall;
  final Function(Map<String, dynamic> traits) identifyCall;
  final Community community;

  ContactsViewModel({
    required this.contacts,
    required this.syncContacts,
    required this.reverseContacts,
    required this.countryCode,
    required this.community,
    required this.isoCode,
    required this.businesses,
    required this.syncContactsRejected,
    required this.trackCall,
    required this.identifyCall,
  });

  static ContactsViewModel fromStore(Store<AppState> store) {
    String communityAddress =
        store.state.cashWalletState.communityAddress ?? defaultCommunityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community();
    return ContactsViewModel(
      isoCode: store.state.userState.isoCode,
      businesses: community.businesses ?? [],
      contacts: store.state.userState.contacts,
      community: community,
      reverseContacts: store.state.userState.reverseContacts,
      countryCode: store.state.userState.countryCode,
      syncContacts: () {
        store.dispatch(syncContactsCall());
      },
      syncContactsRejected: () {
        store.dispatch(new SyncContactsRejected());
      },
      trackCall: (String eventName) {
        store.dispatch(segmentTrackCall(eventName));
      },
      identifyCall: (Map<String, dynamic> traits) {
        store.dispatch(segmentIdentifyCall(traits));
      },
    );
  }

  @override
  List<Object> get props =>
      [contacts, reverseContacts, countryCode, businesses, isoCode, community];
}

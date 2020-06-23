import 'package:contacts_service/contacts_service.dart';
import 'package:digitalrand/constans/exchangable_tokens.dart';
import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/business.dart';
import 'package:digitalrand/models/community.dart';
import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/models/token.dart';
import 'package:digitalrand/models/pro/token.dart' as erc20Token;
import 'package:digitalrand/models/transactions/transactions.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final List<Contact> contacts;
  final Token token;
  final bool isContactsSynced;
  final bool isProMode;
  final Function(List<Contact>) syncContacts;
  final Transactions transactions;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final String isoCode;
  final Function() syncContactsRejected;
  final List<Business> businesses;
  final Function(String eventName) trackCall;
  final Function(Map<String, dynamic> traits) idenyifyCall;
  final erc20Token.Token daiToken;
  final Community community;
  final FeePlugin feePlugin;

  ContactsViewModel(
      {this.contacts,
      this.token,
      this.syncContacts,
      this.isContactsSynced,
      this.isProMode,
      this.feePlugin,
      this.daiToken,
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
    Community community = store.state.cashWalletState.communities[communityAddres];
    erc20Token.Token token = store.state.proWalletState.erc20Tokens.containsKey(dzarToken.address.toLowerCase())
        ? store.state.proWalletState.erc20Tokens[dzarToken.address.toLowerCase()]
        : new erc20Token.Token.initial();
    bool isProMode = store.state.userState.isProMode ?? false;
    return ContactsViewModel(
        daiToken: token,
        feePlugin: isProMode ? community.plugins.foreignTransfers : null,
        isoCode: store.state.userState.isoCode,
        isProMode: isProMode,
        businesses: community?.businesses ?? [],
        isContactsSynced: store.state.userState.isContactsSynced,
        contacts: store.state.userState?.contacts ?? [],
        token: community?.token,
        community: community,
        transactions: community?.transactions,
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
    token,
    isContactsSynced,
    transactions,
    reverseContacts,
    countryCode,
    businesses,
    isoCode,
    community
  ];
}

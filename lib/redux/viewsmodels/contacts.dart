import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final List<Contact> contacts;
  final Function() syncContacts;
  final Map<String, String> reverseContacts;
  final Function() syncContactsRejected;

  const ContactsViewModel({
    required this.contacts,
    required this.syncContacts,
    required this.reverseContacts,
    required this.syncContactsRejected,
  });

  static ContactsViewModel fromStore(Store<AppState> store) {
    final List<Contact> contacts = store.state.userState.contacts;
    return ContactsViewModel(
      contacts: contacts,
      reverseContacts: store.state.userState.reverseContacts,
      syncContacts: () {
        store.dispatch(syncContactsCall());
      },
      syncContactsRejected: () {
        store.dispatch(SyncContactsRejected());
      },
    );
  }

  @override
  List<Object?> get props => [
        contacts,
        reverseContacts,
      ];
}

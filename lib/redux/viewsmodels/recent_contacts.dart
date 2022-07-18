import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class RecentContactsViewModel extends Equatable {
  final List<WalletAction> walletActions;
  final Map<String, String> reverseContacts;
  final List<Contact> contacts;
  final String countryCode;
  final String isoCode;
  const RecentContactsViewModel({
    required this.contacts,
    required this.isoCode,
    required this.walletActions,
    required this.countryCode,
    required this.reverseContacts,
  });

  static RecentContactsViewModel fromStore(Store<AppState> store) {
    final List<WalletAction> walletActions =
        List.from(store.state.cashWalletState.walletActions!.list
            .where(
              (t) =>
                  t.maybeMap(
                    orElse: () => false,
                    send: (value) => true,
                  ) &&
                  t.isConfirmed(),
            )
            .toList()
            .reversed);
    return RecentContactsViewModel(
      walletActions: walletActions,
      isoCode: store.state.userState.isoCode,
      countryCode: store.state.userState.countryCode,
      reverseContacts: store.state.userState.reverseContacts,
      contacts: store.state.userState.contacts,
    );
  }

  @override
  List<Object?> get props => [
        countryCode,
        isoCode,
        walletActions,
        reverseContacts,
        contacts,
      ];
}

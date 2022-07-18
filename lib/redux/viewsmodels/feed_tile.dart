import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:redux/redux.dart';

class FeedTileViewModel extends Equatable {
  final Map<String, String> reverseContacts;
  final List<Contact> contacts;
  final String countryCode;
  final Map<String, Token> tokens;
  final Map<String, String> tokensImages;

  const FeedTileViewModel({
    required this.reverseContacts,
    required this.countryCode,
    required this.tokens,
    required this.contacts,
    required this.tokensImages,
  });

  static FeedTileViewModel fromStore(Store<AppState> store) {
    return FeedTileViewModel(
      tokens: {
        ...store.state.swapState.tokens,
        ...store.state.cashWalletState.tokens
      },
      reverseContacts: store.state.userState.reverseContacts,
      contacts: store.state.userState.contacts,
      countryCode: store.state.userState.countryCode,
      tokensImages: store.state.swapState.tokensImages,
    );
  }

  @override
  List<Object?> get props => [
        reverseContacts,
        countryCode,
        contacts,
        tokens,
        tokensImages,
      ];
}

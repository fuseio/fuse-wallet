import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:redux/redux.dart';

class TransferTileViewModel extends Equatable {
  final Map<String, String> reverseContacts;
  final List<Contact> contacts;
  final String countryCode;
  final Map<String, Token> tokens;
  final Map<String, Community> communitiesMap;
  final Map<String, Community> communities;
  final Map<String, String> tokensImages;

  TransferTileViewModel({
    required this.reverseContacts,
    required this.countryCode,
    required this.tokens,
    required this.contacts,
    required this.tokensImages,
    required this.communities,
    required this.communitiesMap,
  });

  static TransferTileViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .map((Token token) => token.copyWith(
            imageUrl: store.state.cashWalletState.communities
                    .containsKey(token.communityAddress)
                ? store.state.cashWalletState
                    .communities[token.communityAddress]?.metadata
                    ?.getImageUri()
                : null))
        .toList();
    Map<String, Token> tokens =
        [...homeTokens].fold({}, (previousValue, element) {
      previousValue.putIfAbsent(element.address.toLowerCase(), () => element);
      return previousValue;
    });

    Map<String, Community> communitiesMap =
        communities.fold({}, (previousValue, element) {
      if (element.homeTokenAddress.isNotEmpty) {
        previousValue.putIfAbsent(element.homeTokenAddress, () => element);
      }
      return previousValue;
    });
    return TransferTileViewModel(
      tokens: tokens,
      reverseContacts: store.state.userState.reverseContacts,
      contacts: store.state.userState.contacts,
      countryCode: store.state.userState.countryCode,
      communitiesMap: communitiesMap,
      communities: store.state.cashWalletState.communities,
      tokensImages: store.state.swapState.tokensImages,
    );
  }

  @override
  List<Object> get props => [
        communities,
        reverseContacts,
        countryCode,
        contacts,
        tokens,
        communitiesMap,
        tokensImages
      ];
}

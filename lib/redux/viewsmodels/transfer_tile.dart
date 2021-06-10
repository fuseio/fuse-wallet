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
  final Map<String, Token> erc20Tokens;
  final Map<String, Token> tokens;
  final Map<String, Community> communitiesMap;
  final Map<String, Community> communities;
  final Map<String, String> tokensImages;

  TransferTileViewModel({
    required this.reverseContacts,
    required this.countryCode,
    required this.erc20Tokens,
    required this.tokens,
    required this.contacts,
    required this.tokensImages,
    required this.communities,
    required this.communitiesMap,
  });

  static TransferTileViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .toList();
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
        [...foreignTokens, ...homeTokens].fold(Map(), (previousValue, element) {
      previousValue.putIfAbsent(element.address.toLowerCase(), () => element);
      return previousValue;
    });

    Map<String, Community> communitiesMap =
        communities.fold(Map(), (previousValue, element) {
      previousValue.putIfAbsent(element.homeTokenAddress, () => element);
      return previousValue;
    });
    return TransferTileViewModel(
      tokens: tokens,
      reverseContacts: store.state.userState.reverseContacts,
      contacts: store.state.userState.contacts,
      countryCode: store.state.userState.countryCode,
      erc20Tokens: store.state.proWalletState.erc20Tokens!,
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
        erc20Tokens,
        tokens,
        communitiesMap,
        tokensImages
      ];
}

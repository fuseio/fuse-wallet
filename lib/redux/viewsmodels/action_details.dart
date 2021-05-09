import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:redux/redux.dart';

class ActionDetailsViewModel extends Equatable {
  final Map<String, Token> tokens;
  final Map<String, String> tokensImages;

  ActionDetailsViewModel({
    required this.tokens,
    required this.tokensImages,
  });

  static ActionDetailsViewModel fromStore(Store<AppState> store) {
    List<Token> homeTokens = List<Token>.from(
        store.state?.cashWalletState?.tokens?.values ?? Iterable.empty());
    Map<String, Token> tokens =
        [...homeTokens].fold(Map(), (previousValue, element) {
      previousValue.putIfAbsent(element?.address?.toLowerCase(), () => element);
      return previousValue;
    });

    return ActionDetailsViewModel(
      tokens: tokens,
      tokensImages: store.state.swapState?.tokensImages ?? Map(),
    );
  }

  @override
  List<Object> get props => [tokens, tokensImages];
}

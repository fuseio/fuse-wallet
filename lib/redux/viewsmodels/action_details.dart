import 'package:equatable/equatable.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:redux/redux.dart';

class ActionDetailsViewModel extends Equatable {
  final Map<String, Token> tokens;
  final Map<String, String> tokensImages;

  ActionDetailsViewModel({
    required this.tokens,
    required this.tokensImages,
  });

  static ActionDetailsViewModel fromStore(Store<AppState> store) {
    return ActionDetailsViewModel(
      tokens: store.state.cashWalletState.tokens,
      tokensImages: {}, //store.state.swapState.tokensImages,
    );
  }

  @override
  List<Object> get props => [tokens, tokensImages];
}

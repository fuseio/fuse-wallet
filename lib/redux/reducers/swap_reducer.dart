import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:redux/redux.dart';

final swapReducers = combineReducers<SwapState>([
  TypedReducer<SwapState, GetSwappableTokensSuccess>(
      _getSwappableTokensSuccess),
  TypedReducer<SwapState, GetTokensImagesSuccess>(_getTokensImagesSuccess),
  TypedReducer<SwapState, ResetTokenList>(_resetTokenList),
  TypedReducer<SwapState, UpdateTokenPrices>(_updateTokenPrices),
  TypedReducer<SwapState, UpdateTokenBalance>(_updateTokenBalance),
]);

SwapState _updateTokenPrices(SwapState state, UpdateTokenPrices action) {
  final Token token = state.tokens[action.tokenAddress].copyWith(
    priceInfo: action.priceInfo,
    priceChange: action.priceChange,
  );
  Map<String, Token> tokens = Map<String, Token>.from(state.tokens);
  tokens[action.tokenAddress] = token.copyWith();
  return (state ?? SwapState())?.copyWith(
    tokens: tokens,
  );
}

SwapState _updateTokenBalance(SwapState state, UpdateTokenBalance action) {
  final Token token = state.tokens[action.tokenAddress].copyWith(
    amount: action.balance
  );
  Map<String, Token> tokens = Map<String, Token>.from(state.tokens);
  tokens[action.tokenAddress] = token.copyWith();
  return (state ?? SwapState())?.copyWith(
    tokens: tokens,
  );
}

SwapState _resetTokenList(SwapState state, ResetTokenList action) {
  return (state ?? SwapState())?.copyWith(
    tokens: {},
  );
}

SwapState _getSwappableTokensSuccess(
    SwapState state, GetSwappableTokensSuccess action) {
  return (state ?? SwapState())?.copyWith(
    tokens: action.swappableTokens,
  );
}

SwapState _getTokensImagesSuccess(
    SwapState state, GetTokensImagesSuccess action) {
  Map<String, String> newOne = Map();
  for (String tokenAddress in action.tokensImages.keys) {
    if (!state.tokensImages.containsKey(tokenAddress)) {
      newOne[tokenAddress] = action.tokensImages[tokenAddress];
    } else if (state.tokensImages.containsKey(tokenAddress) &&
        state.tokensImages[tokenAddress] != action.tokensImages[tokenAddress]) {
      newOne[tokenAddress] = action.tokensImages[tokenAddress];
    }
  }
  if (newOne.isEmpty) {
    return state;
  }
  Map<String, String> tokensImages =
      Map<String, String>.from(state.tokensImages)..addAll(newOne);
  return (state ?? SwapState())?.copyWith(
    tokensImages: tokensImages,
  );
}

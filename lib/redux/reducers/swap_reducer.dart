import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:redux/redux.dart';

final swapReducers = combineReducers<SwapState>([
  TypedReducer<SwapState, GetSwappableTokensSuccess>(
      _getSwappableTokensSuccess),
  TypedReducer<SwapState, GetTokensImagesSuccess>(_getTokensImagesSuccess),
  TypedReducer<SwapState, ResetTokenList>(_resetTokenList),
]);

SwapState _resetTokenList(SwapState state, ResetTokenList action) =>
    SwapState(tokens: {});

SwapState _getSwappableTokensSuccess(
    SwapState state, GetSwappableTokensSuccess action) {
  return (state ?? SwapState())?.copyWith(
    tokens: action.swappableTokens,
  );
}

SwapState _getTokensImagesSuccess(
    SwapState state, GetTokensImagesSuccess action) {
  return (state ?? SwapState())?.copyWith(
    tokensImages: action.tokensImages,
  );
}

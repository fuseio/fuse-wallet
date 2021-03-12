import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:redux/redux.dart';

final swapReducers = combineReducers<SwapState>([
  TypedReducer<SwapState, FetchTokenList>(_fetchTokenList),
]);

SwapState _fetchTokenList(SwapState state, FetchTokenList action) {
  return (state ?? SwapState())?.copyWith(
    tokensList: action.fetchSwapList
      ..sort(
        (tokenA, tokenB) => (tokenB?.amount ?? BigInt.zero)?.compareTo(
          tokenA?.amount ?? BigInt.zero,
        ),
      ),
  );
}

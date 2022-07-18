import 'package:fusecash/models/nft/state.dart';
import 'package:fusecash/redux/actions/nft_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

final nftReducers = combineReducers<NftsState>([
  TypedReducer<NftsState, AddCollectibles>(_addCollectibles),
  TypedReducer<NftsState, CreateLocalAccountSuccess>(_createNewWalletSuccess),
]);

NftsState _addCollectibles(
  NftsState state,
  AddCollectibles action,
) {
  return state.copyWith(
    collectibles: action.collectibles,
  );
}

NftsState _createNewWalletSuccess(
  NftsState state,
  CreateLocalAccountSuccess action,
) {
  return NftsState();
}

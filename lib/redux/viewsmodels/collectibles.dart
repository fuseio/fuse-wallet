import 'package:charge_wallet_sdk/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/nft_actions.dart';

class CollectiblesViewModel extends Equatable {
  final List<Collectible> collectibles;
  final Function() refreshCollectibles;
  @override
  List<Object?> get props => [collectibles];
  const CollectiblesViewModel({
    required this.collectibles,
    required this.refreshCollectibles,
  });

  static CollectiblesViewModel fromStore(Store<AppState> store) {
    return CollectiblesViewModel(
      collectibles: [
        ...store.state.nftsState.collectibles.values
            .map((e) => e.values.toList())
            .expand((element) => element)
            .toList()
      ],
      refreshCollectibles: () {
        store.dispatch(fetchCollectibles());
      },
    );
  }
}

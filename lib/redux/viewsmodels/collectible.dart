import 'package:charge_wallet_sdk/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';

class CollectibleViewModel extends Equatable {
  final Map<String, Map<int, Collectible>> collectibles;
  @override
  List<Object?> get props => [collectibles];
  const CollectibleViewModel({
    required this.collectibles,
  });

  static CollectibleViewModel fromStore(Store<AppState> store) {
    return CollectibleViewModel(
      collectibles: store.state.nftsState.collectibles,
    );
  }
}

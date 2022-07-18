import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';

class TradeCardViewModel extends Equatable {
  final Map<String, String> tokensImages;

  const TradeCardViewModel({
    required this.tokensImages,
  });

  static TradeCardViewModel fromStore(Store<AppState> store) {
    return TradeCardViewModel(
      tokensImages: store.state.swapState.tokensImages,
    );
  }

  @override
  List<Object?> get props => [
        tokensImages,
      ];
}

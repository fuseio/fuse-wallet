import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

class TradeCardViewModel extends Equatable {
  final Map<String, String> tokensImages;

  TradeCardViewModel({
    required this.tokensImages,
  });

  static TradeCardViewModel fromStore(Store<AppState> store) {
    return TradeCardViewModel(
      tokensImages: store.state.swapState.tokensImages,
    );
  }

  @override
  List<Object> get props => [
        tokensImages,
      ];
}

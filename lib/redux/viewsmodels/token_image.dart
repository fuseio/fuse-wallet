import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';

class TokenImageViewModel {
  final Map<String, String> tokensImages;

  TokenImageViewModel({
    required this.tokensImages,
  });

  static TokenImageViewModel fromStore(Store<AppState> store) {
    return TokenImageViewModel(
      tokensImages: store.state.swapState.tokensImages,
    );
  }
}

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';

class TradeCardViewModel extends Equatable {
  final Map<String, String> tokensImages;

  TradeCardViewModel({
    this.tokensImages,
  });

  static TradeCardViewModel fromStore(Store<AppState> store) {
    return TradeCardViewModel(
      tokensImages: store.state.swapState?.tokensImages ?? Map(),
    );
  }

  @override
  List<Object> get props => [
        tokensImages,
      ];
}

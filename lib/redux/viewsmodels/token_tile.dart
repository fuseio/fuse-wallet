import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';

class TokenTileViewModel extends Equatable {
  final List<Community> communities;

  TokenTileViewModel({this.communities});

  static TokenTileViewModel fromStore(Store<AppState> store) {
    return TokenTileViewModel(
      communities: store.state.cashWalletState.communities.values.toList(),
    );
  }

  @override
  List<Object> get props => [communities];
}

import 'package:equatable/equatable.dart';
import 'package:supervecina/models/plugins.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/community.dart';

class PrizeViewModel extends Equatable {
  final Plugins plugins;

  PrizeViewModel({this.plugins});

  static PrizeViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return PrizeViewModel(plugins: community?.plugins);
  }

  @override
  List<Object> get props => [plugins];
}

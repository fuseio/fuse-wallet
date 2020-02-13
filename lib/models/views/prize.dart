import 'package:equatable/equatable.dart';
import 'package:paywise/models/draw_info.dart';
import 'package:paywise/models/plugins.dart';
import 'package:redux/redux.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/community.dart';

class PrizeViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final DrawInfo drawInfo;
  final Plugins plugins;

  PrizeViewModel({this.community, this.firstName, this.drawInfo, this.plugins});

  static PrizeViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return PrizeViewModel(
      community: community,
      plugins: community?.plugins,
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      });
  }

  @override
  List<Object> get props => [community];
}
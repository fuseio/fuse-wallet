import 'package:equatable/equatable.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/utils/addresses.dart' as util;
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community.dart';

class PrizeViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final Plugins plugins;
  final bool isDefaultCommunity;

  PrizeViewModel({this.community, this.firstName, this.plugins, this.isDefaultCommunity});

  static PrizeViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return PrizeViewModel(
      isDefaultCommunity: util.isDefaultCommunity(communityAddres),
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
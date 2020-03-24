import 'package:equatable/equatable.dart';
import 'package:localpay/models/plugins.dart';
import 'package:localpay/utils/addresses.dart' as util;
import 'package:redux/redux.dart';
import 'package:localpay/models/app_state.dart';
import 'package:localpay/models/community.dart';

class PrizeViewModel extends Equatable {
  final Community community;
  final Plugins plugins;
  final bool isDefaultCommunity;
  final Function() firstName;

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
  List<Object> get props => [community, isDefaultCommunity, plugins];
}
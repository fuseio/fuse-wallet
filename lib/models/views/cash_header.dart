import 'package:equatable/equatable.dart';
import 'package:paywise/models/community.dart';
import 'package:paywise/models/plugins/plugins.dart';
import 'package:redux/redux.dart';
import 'package:paywise/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final Plugins plugins;
  final String walletStatus;

  CashHeaderViewModel(
      {this.community, this.firstName, this.plugins, this.walletStatus});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return CashHeaderViewModel(
        community: community,
        plugins: community?.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props => [community, plugins, walletStatus];
}

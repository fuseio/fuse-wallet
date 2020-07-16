import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/plugins/plugins.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final Plugins plugins;
  final String walletStatus;
  final String usdValue;
  final String dzarValue;

  CashHeaderViewModel(
      {this.usdValue,
      this.dzarValue,
      this.firstName,
      this.plugins,
      this.walletStatus});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    num dzarValue = store.state.userState?.totalBalance ?? 0;
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            new Community.initial();
    return CashHeaderViewModel(
        dzarValue: reduce(dzarValue),
        plugins: community?.plugins,
        walletStatus: store.state.userState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props => [plugins, walletStatus, usdValue, dzarValue];
}

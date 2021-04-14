import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';

class TopUpViewModel extends Equatable {
  final Function setDepositBanner;
  final Plugins plugins;
  final Function dismiss;

  TopUpViewModel({
    this.setDepositBanner,
    this.plugins,
    this.dismiss,
  });

  static TopUpViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress];

    return TopUpViewModel(
      plugins: community?.plugins ?? Plugins(),
      setDepositBanner: () {
        store.dispatch(DepositBannerShowed());
      },
      dismiss: () {
        store.dispatch(SetShowDepositBanner());
      },
    );
  }

  @override
  List get props => [
        plugins,
      ];
}

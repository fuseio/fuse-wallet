import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/community/community.dart';

class TopUpViewModel extends Equatable {
  final Function setDepositBanner;
  final Plugins plugins;

  TopUpViewModel({
    this.setDepositBanner,
    this.plugins,
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
    );
  }

  @override
  List get props => [
        plugins,
      ];
}

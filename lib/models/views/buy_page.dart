import 'package:seedbed/models/community/business.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/models/plugins/wallet_banner.dart';
import 'package:seedbed/models/tokens/token.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final Function() loadBusinesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final String communityAddress;
  final WalletBannerPlugin walletBanner;

  @override
  List<Object> get props => [
        token,
        businesses,
        isCommunityBusinessesFetched,
        businesses,
        walletBanner
      ];

  BuyViewModel(
      {this.communityAddress,
      this.businesses,
      this.loadBusinesses,
      this.token,
      this.isCommunityBusinessesFetched,
      this.walletBanner});

  static BuyViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return BuyViewModel(
        communityAddress: communityAddress,
        token: community?.token,
        businesses: community?.businesses ?? [],
        walletBanner: community.plugins.walletBanner,
        isCommunityBusinessesFetched:
            store.state.cashWalletState.isCommunityBusinessesFetched,
        loadBusinesses: () {
          store.dispatch(getBusinessListCall());
        });
  }
}

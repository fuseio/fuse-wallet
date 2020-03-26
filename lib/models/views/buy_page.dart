import 'package:roost/models/business.dart';
import 'package:roost/models/community.dart';
import 'package:roost/models/plugins.dart';
import 'package:roost/models/token.dart';
import 'package:roost/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:roost/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final Function() loadBusinesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final String communityAddres;
  final WalletBannerPlugin walletBanner;

  @override
  List<Object> get props => [token, businesses, isCommunityBusinessesFetched, businesses, walletBanner];

  BuyViewModel({
    this.communityAddres,
    this.businesses,
    this.loadBusinesses,
    this.token,
    this.isCommunityBusinessesFetched,
    this.walletBanner
  });

  static BuyViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return BuyViewModel(
      communityAddres: communityAddres,
      token: community?.token,
      businesses: community?.businesses ?? [],
      walletBanner: community.plugins.walletBanner,
      isCommunityBusinessesFetched: store.state.cashWalletState.isCommunityBusinessesFetched,
      loadBusinesses: () {
        store.dispatch(getBusinessListCall());
      });
  }
}

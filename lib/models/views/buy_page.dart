import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/community/community.dart';
import 'package:supervecina/models/plugins/wallet_banner.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final String communityAddress;

  @override
  List<Object> get props => [
        token,
        businesses,
        isCommunityBusinessesFetched,
        businesses,
      ];

  BuyViewModel({
    this.communityAddress,
    this.businesses,
    this.token,
    this.isCommunityBusinessesFetched,
  });

  static BuyViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community.initial();
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return BuyViewModel(
      communityAddress: communityAddress,
      token: token,
      businesses: community?.businesses ?? [],
      isCommunityBusinessesFetched:
          store.state.cashWalletState.isCommunityBusinessesFetched,
    );
  }
}

class BannerViewModel extends Equatable {
  final WalletBannerPlugin walletBanner;

  @override
  List<Object> get props => [walletBanner];

  BannerViewModel({
    this.walletBanner,
  });

  static BannerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community.initial();
    return BannerViewModel(
      walletBanner: community?.plugins?.walletBanner,
    );
  }
}

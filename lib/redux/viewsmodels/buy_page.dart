import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/community/community.dart';
import 'package:supervecina/models/plugins/wallet_banner.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:redux/redux.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:supervecina/utils/constants.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final WalletBannerPlugin? walletBanner;

  @override
  List<Object> get props => [
        token,
        businesses,
        isCommunityBusinessesFetched,
        businesses,
      ];

  BuyViewModel({
    required this.businesses,
    required this.token,
    required this.isCommunityBusinessesFetched,
    required this.walletBanner,
  });

  static BuyViewModel fromStore(Store<AppState> store) {
    String? communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress]!;
    Token token =
        store.state.cashWalletState.tokens[community.homeTokenAddress] ??
            illaToken;
    return BuyViewModel(
      token: token,
      businesses: community.businesses ?? [],
      walletBanner: community.plugins?.walletBanner,
      isCommunityBusinessesFetched:
          store.state.cashWalletState.isCommunityBusinessesFetched,
    );
  }
}

import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community.dart';
// import 'package:fusecash/models/plugins/wallet_banner.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final bool isCommunityBusinessesFetched;
  final Token? token;
  final String communityAddress;

  @override
  List<Object> get props => [
        isCommunityBusinessesFetched,
        businesses,
      ];

  BuyViewModel({
    required this.communityAddress,
    required this.businesses,
    required this.token,
    required this.isCommunityBusinessesFetched,
  });

  static BuyViewModel fromStore(Store<AppState> store) {
    String? communityAddress = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState
        .communities[defaultCommunityAddress.toLowerCase()]!;
    Token? token =
        store.state.cashWalletState.tokens[community.homeTokenAddress];
    return BuyViewModel(
      communityAddress: communityAddress,
      token: token,
      businesses: community.businesses ?? [],
      isCommunityBusinessesFetched:
          store.state.cashWalletState.isCommunityBusinessesFetched,
    );
  }
}

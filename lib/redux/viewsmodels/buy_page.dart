import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community.dart';
// import 'package:fusecash/models/plugins/wallet_banner.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final String communityAddress;

  @override
  List<Object> get props => [
        isCommunityBusinessesFetched,
        businesses,
        token,
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
    Token token = store.state.cashWalletState.tokens[curaDAIToken.address]!;
    final List<Business> businesses = [...?community.businesses]
      ..sort((a, b) => a.name.compareTo(b.name))
      ..toList();
    return BuyViewModel(
      communityAddress: communityAddress,
      token: token,
      businesses: businesses,
      isCommunityBusinessesFetched:
          store.state.cashWalletState.isCommunityBusinessesFetched,
    );
  }
}

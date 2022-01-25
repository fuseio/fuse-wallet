import 'dart:math';

import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:supervecina/models/actions/actions.dart';
import 'package:supervecina/models/actions/wallet_action.dart';
import 'package:supervecina/models/community/community.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/redux/actions/user_actions.dart';
import 'package:supervecina/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';

bool clearTokensWithZero(key, token) {
  if (token.timestamp == 0) return false;
  double formattedValue = token.amount / BigInt.from(pow(10, token.decimals));
  return num.parse(formattedValue.toString()).compareTo(0) != 1;
}

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, GetTokenPriceDiffSuccess>(
      _getTokenPriceDiffSuccess),
  TypedReducer<CashWalletState, GetTokenStatsSuccess>(_getTokenStatsSuccess),
  TypedReducer<CashWalletState, GetTokenPriceChangeSuccess>(
      _getTokenPriceChangeSuccess),
  TypedReducer<CashWalletState, UpdateTokenPrice>(_updateTokenPrice),
  TypedReducer<CashWalletState, GetActionsSuccess>(_getActionsSuccess),
  TypedReducer<CashWalletState, GetTokenWalletActionsSuccess>(
      _getTokenWalletActionsSuccess),
  TypedReducer<CashWalletState, AddCashTokens>(_addCashTokens),
  TypedReducer<CashWalletState, AddCashToken>(_addCashToken),
  TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
  TypedReducer<CashWalletState, GetTokenBalanceSuccess>(
      _getTokenBalanceSuccess),
  TypedReducer<CashWalletState, FetchCommunityMetadataSuccess>(
      _fetchCommunityMetadataSuccess),
  TypedReducer<CashWalletState, AlreadyJoinedCommunity>(
      _alreadyJoinedCommunity),
  TypedReducer<CashWalletState, ResetTokenTxs>(_resetTokensTxs),
  TypedReducer<CashWalletState, RefreshCommunityData>(_refreshCommunityData),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(
      _switchCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunityFailed>(_switchCommunityFailed),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(
      _getBusinessListSuccess),
  TypedReducer<CashWalletState, SwitchCommunityRequested>(
      _switchCommunityRequest),
  TypedReducer<CashWalletState, SwitchToNewCommunity>(_switchToNewCommunity),
  TypedReducer<CashWalletState, SetIsTransfersFetching>(
      _setIsTransfersFetching),
  TypedReducer<CashWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
  TypedReducer<CashWalletState, StartFetchingBusinessList>(
      _startFetchingBusinessList),
  TypedReducer<CashWalletState, FetchingBusinessListSuccess>(
      _fetchingBusinessListSuccess),
  TypedReducer<CashWalletState, FetchingBusinessListFailed>(
      _fetchingBusinessListFailed),
  TypedReducer<CashWalletState, SetIsFetchingBalances>(_setIsFetchingBalances),
  TypedReducer<CashWalletState, SetShowDepositBanner>(_setShowDepositBanner)
]);

CashWalletState _getTokenPriceDiffSuccess(
  CashWalletState state,
  GetTokenPriceDiffSuccess action,
) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress]!;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(
    priceDiff: action.priceDiff,
    priceDiffLimitInDays: action.priceDiffLimitInDays,
  );
  return state.copyWith(tokens: newOne);
}

CashWalletState _updateTokenPrice(
  CashWalletState state,
  UpdateTokenPrice action,
) {
  Token token = state.tokens[action.tokenAddress]!;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[token.address] = token.copyWith(priceInfo: action.price);
  return state.copyWith(tokens: newOne);
}

CashWalletState _getTokenWalletActionsSuccess(
  CashWalletState state,
  GetTokenWalletActionsSuccess action,
) {
  Token token = state.tokens[action.token.address]!;
  List<WalletAction> walletActions = token.walletActions!.list;
  for (WalletAction walletAction in action.walletActions) {
    int savedIndex = walletActions.indexWhere(
      (action) => action.id == walletAction.id,
    );
    if (savedIndex != -1) {
      walletActions[savedIndex] = walletAction;
    } else {
      walletActions.add(walletAction);
    }
  }

  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[token.address] = token.copyWith(
    walletActions: WalletActions().copyWith(
      list: walletActions,
      updatedAt: action.updateAt + 1,
    ),
  );
  return state.copyWith(
    tokens: newOne,
  );
}

CashWalletState _getActionsSuccess(
  CashWalletState state,
  GetActionsSuccess action,
) {
  List<WalletAction> list = state.walletActions!.list;
  for (WalletAction walletAction in action.walletActions) {
    int savedIndex = list.indexWhere(
      (action) => action.id == walletAction.id,
    );
    if (savedIndex != -1) {
      list[savedIndex] = walletAction.copyWith();
    } else {
      list.add(walletAction);
    }
  }
  return state.copyWith(
    walletActions: WalletActions().copyWith(
      list: list..sort(),
      currentPage: action.nextPage,
    ),
  );
}

CashWalletState _addCashTokens(
  CashWalletState state,
  AddCashTokens action,
) {
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne.removeWhere(clearTokensWithZero);
  for (String tokenAddress in action.tokens.keys) {
    if (newOne.containsKey(tokenAddress)) {
      newOne[tokenAddress] = newOne[tokenAddress]!.copyWith(
        amount: action.tokens[tokenAddress]!.amount,
      );
    } else {
      newOne[tokenAddress] = action.tokens[tokenAddress]!;
    }
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _addCashToken(
  CashWalletState state,
  AddCashToken action,
) {
  Token token = action.token;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne.removeWhere(clearTokensWithZero);
  if (!newOne.containsKey(token.address)) {
    newOne[token.address] = token;
  } else {
    newOne[token.address] = newOne[token.address]!.copyWith(
      name: token.name,
      communityAddress: token.communityAddress,
    );
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _resetTokensTxs(
  CashWalletState state,
  ResetTokenTxs action,
) {
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  Map<String, Token> tokens = {};
  final List<String> tokenAddresses = List<String>.from(
      newOne.keys.map((e) => e.toLowerCase()).toSet().toList());
  for (String tokenAddress in tokenAddresses) {
    final Token token =
        newOne.containsKey(checksumEthereumAddress(tokenAddress))
            ? newOne[checksumEthereumAddress(tokenAddress)]!
            : newOne[tokenAddress]!;
    tokens[tokenAddress] = token.copyWith(
      walletActions: token.walletActions!.copyWith(
        updatedAt: 0,
      ),
    );
  }
  return state.copyWith(
    tokens: tokens,
    walletActions: state.walletActions!.copyWith(
      updatedAt: 0,
    ),
  );
}

CashWalletState _refreshCommunityData(
  CashWalletState state,
  RefreshCommunityData action,
) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community current = state.communities[communityAddress]!;
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = current.copyWith(
    plugins: action.plugins,
    webUrl: action.webUrl,
  );
  return state.copyWith(communities: newOne);
}

CashWalletState _fetchCommunityMetadataSuccess(
  CashWalletState state,
  FetchCommunityMetadataSuccess action,
) {
  Community current = state.communities[action.communityAddress] ??
      Community(address: action.communityAddress);
  Community newCommunity = current.copyWith(metadata: action.metadata);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.communityAddress] = newCommunity;
  return state.copyWith(communities: newOne);
}

CashWalletState _setDefaultCommunity(
  CashWalletState state,
  SetDefaultCommunity action,
) {
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.defaultCommunity] = Community(address: action.defaultCommunity);
  return state.copyWith(
    communityAddress: action.defaultCommunity,
    communities: newOne,
    walletActions: WalletActions.initial(),
  );
}

CashWalletState _getTokenBalanceSuccess(
  CashWalletState state,
  GetTokenBalanceSuccess action,
) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress]!;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(amount: action.tokenBalance);
  return state.copyWith(tokens: newOne);
}

CashWalletState _alreadyJoinedCommunity(
    CashWalletState state, AlreadyJoinedCommunity action) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community current = state.communities[communityAddress] ??
      Community(address: communityAddress);
  if (state.communities.containsKey(communityAddress) && !current.isMember) {
    Community newCommunity = current.copyWith(isMember: true);
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  } else {
    return state;
  }
}

CashWalletState _getTokenPriceChangeSuccess(
  CashWalletState state,
  GetTokenPriceChangeSuccess action,
) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress]!;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(priceChange: action.priceChange);
  return state.copyWith(tokens: newOne);
}

CashWalletState _getTokenStatsSuccess(
  CashWalletState state,
  GetTokenStatsSuccess action,
) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress]!;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(stats: action.stats);
  return state.copyWith(tokens: newOne);
}

CashWalletState _switchCommunitySuccess(
  CashWalletState state,
  SwitchCommunitySuccess action,
) {
  String communityAddress = action.community.address.toLowerCase();
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = action.community;
  return state.copyWith(
    isCommunityLoading: false,
    isCommunityFetched: true,
    communities: newOne,
    communityAddress: communityAddress,
  );
}

CashWalletState _switchCommunityFailed(
  CashWalletState state,
  SwitchCommunityFailed action,
) {
  Map<String, Community> newOne = Map<String, Community>.from(
    state.communities
      ..remove(
        action.communityAddress.toLowerCase(),
      ),
  );
  return state.copyWith(
    isCommunityLoading: false,
    communities: newOne,
  );
}

CashWalletState _startFetchingBusinessList(
  CashWalletState state,
  StartFetchingBusinessList action,
) {
  return state.copyWith(isCommunityBusinessesFetched: true);
}

CashWalletState _getBusinessListSuccess(
  CashWalletState state,
  GetBusinessListSuccess action,
) {
  final String communityAddress = action.communityAddress;
  Community current = state.communities[communityAddress] ??
      Community(address: communityAddress);
  Community newCommunity = current.copyWith(businesses: action.businessList);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = newCommunity;
  return state.copyWith(communities: newOne);
}

CashWalletState _fetchingBusinessListSuccess(
  CashWalletState state,
  FetchingBusinessListSuccess action,
) {
  return state.copyWith(isCommunityBusinessesFetched: false);
}

CashWalletState _fetchingBusinessListFailed(
  CashWalletState state,
  FetchingBusinessListFailed action,
) {
  return state.copyWith(isCommunityBusinessesFetched: false);
}

CashWalletState _switchCommunityRequest(
  CashWalletState state,
  SwitchCommunityRequested action,
) {
  return state.copyWith(
    isCommunityLoading: true,
    communityAddress: action.communityAddress.toLowerCase(),
  );
}

CashWalletState _switchToNewCommunity(
  CashWalletState state,
  SwitchToNewCommunity action,
) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community newCommunity = Community(address: communityAddress);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = newCommunity;
  return state.copyWith(
    isCommunityLoading: true,
    communities: newOne,
  );
}

CashWalletState _setIsTransfersFetching(
  CashWalletState state,
  SetIsTransfersFetching action,
) {
  return state.copyWith(isTransfersFetchingStarted: action.isFetching);
}

CashWalletState _createNewWalletSuccess(
  CashWalletState state,
  CreateLocalAccountSuccess action,
) {
  return CashWalletState.initial();
}

CashWalletState _setIsFetchingBalances(
  CashWalletState state,
  SetIsFetchingBalances action,
) {
  return state.copyWith(isFetchingBalances: action.isFetching);
}

CashWalletState _setShowDepositBanner(
  CashWalletState state,
  SetShowDepositBanner action,
) {
  return state.copyWith(
    isDepositBanner: false,
  );
}

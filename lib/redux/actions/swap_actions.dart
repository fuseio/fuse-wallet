import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart';

class SetFetchingState {
  final bool isFetching;
  SetFetchingState({
    required this.isFetching,
  });
}

class GetSwappableTokensSuccess {
  final Map<String, Token> swappableTokens;
  GetSwappableTokensSuccess({
    required this.swappableTokens,
  });
}

class UpdateTokenPrices {
  final num priceChange;
  final Price priceInfo;
  final String tokenAddress;
  UpdateTokenPrices({
    required this.priceInfo,
    required this.priceChange,
    required this.tokenAddress,
  });
}

class UpdateTokenBalance {
  final BigInt balance;
  final String tokenAddress;
  UpdateTokenBalance({
    required this.balance,
    required this.tokenAddress,
  });
}

class GetTokensImagesSuccess {
  final Map<String, String> tokensImages;
  GetTokensImagesSuccess({
    required this.tokensImages,
  });
}

class ResetTokenList {}

ThunkAction fetchSwapList() {
  return (Store store) async {
    try {
      store.dispatch(SetFetchingState(isFetching: true));
      final dio = getIt<Dio>();
      Response<String> response =
          await dio.get(UrlConstants.FUSESWAP_TOKEN_LIST);
      Map data = jsonDecode(response.data!);
      Map<String, Token> tokens = {};
      Map<String, String> tokensImages = {};
      for (Map token in data['tokens']) {
        final String tokenAddress = token['address'].toLowerCase();
        final String name = Formatter.formatTokenName(token["name"]);
        final String symbol = token['symbol'];
        Token newToken = Token.fromJson({
          "originNetwork": 'mainnet',
          "amount": BigInt.zero.toString(),
          "address": tokenAddress,
          "decimals": token['decimals'],
          "name": name,
          "symbol": symbol,
          "imageUrl": token['logoURI'],
        });
        tokens.putIfAbsent(
          tokenAddress,
          () => newToken,
        );
        tokensImages.putIfAbsent(
          tokenAddress,
          () => token['logoURI'],
        );
      }
      tokens.addEntries([
        MapEntry(
          fuseToken.address.toLowerCase(),
          fuseToken,
        )
      ]);

      tokensImages.addEntries([
        MapEntry(
          fuseToken.address.toLowerCase(),
          fuseToken.imageUrl!,
        )
      ]);

      store.dispatch(GetSwappableTokensSuccess(
        swappableTokens: tokens,
      ));
      store.dispatch(fetchSwapListPrices());
      if (tokensImages.isNotEmpty) {
        store.dispatch(GetTokensImagesSuccess(
          tokensImages: tokensImages,
        ));
      }
    } catch (e, s) {
      log.error(
        'ERROR - fetchSwapList',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction fetchSwapListPrices() {
  return (Store store) async {
    try {
      SwapState swapState = store.state.swapState;
      for (Token token in swapState.tokens.values) {
        Future<List<dynamic>> prices = Future.wait([
          fuseSwapService.price(token.address),
          fuseSwapService.priceChange(token.address)
        ]);
        List<dynamic> result = await prices;
        store.dispatch(UpdateTokenPrices(
          tokenAddress: token.address,
          priceChange: result[1],
          priceInfo: result[0],
        ));
      }
      store.dispatch(SetFetchingState(isFetching: false));
    } catch (e, s) {
      log.error(
        'ERROR - fetchSwapListPrices',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction fetchSwapBalances() {
  return (Store store) async {
    try {
      SwapState swapState = store.state.swapState;
      String walletAddress = store.state.userState.walletAddress;
      for (Token token in swapState.tokens.values) {
        BigInt balance;
        if (token.isNative) {
          EtherAmount etherAmount =
              await getIt<Web3>(instanceName: 'fuseWeb3').getBalance(
            address: walletAddress,
          );
          balance = etherAmount.getInWei;
        } else {
          final BigInt tokenBalance =
              await getIt<Web3>(instanceName: 'fuseWeb3').getTokenBalance(
            token.address,
            address: walletAddress,
          );
          balance = tokenBalance;
        }
        store.dispatch(UpdateTokenBalance(
          tokenAddress: token.address,
          balance: balance,
        ));
      }
    } catch (e, s) {
      log.error(
        'ERROR - fetchSwapBalances',
        error: e,
        stackTrace: s,
      );
    }
  };
}

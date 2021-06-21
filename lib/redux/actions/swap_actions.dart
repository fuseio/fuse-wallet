import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
      store.dispatch(ResetTokenList());
      final dio = getIt<Dio>();
      Response<String> response =
          await dio.get(UrlConstants.FUSESWAP_TOKEN_LIST);
      Map data = jsonDecode(response.data!);
      Map<String, Token> tokens = Map();
      Map<String, String> tokensImages = Map();
      for (Map token in data['tokens']) {
        final String name = formatTokenName(token["name"]);
        if (name.startsWith('Dai')) {
          continue;
        }
        if (!token.containsKey('isDeprecated')) {
          final String symbol = token['symbol'];
          Token newToken = Token.fromJson({
            "originNetwork": 'mainnet',
            "amount": BigInt.zero.toString(),
            "address": token['address'].toLowerCase(),
            "decimals": token['decimals'],
            "name": name.contains('Wrapped Fuse') ? 'Fuse' : name,
            "symbol": symbol == 'WFUSE' ? 'FUSE' : symbol,
            "imageUrl": token['logoURI'],
          });
          tokens.putIfAbsent(
            token['address'].toLowerCase(),
            () => newToken,
          );
          tokensImages.putIfAbsent(
            token['address'].toLowerCase(),
            () => token['logoURI'],
          );
        }
      }

      store.dispatch(GetSwappableTokensSuccess(
        swappableTokens: tokens,
      ));
      store.dispatch(fetchSwapBalances());

      if (tokensImages.isNotEmpty) {
        store.dispatch(GetTokensImagesSuccess(
          tokensImages: tokensImages,
        ));
      }
    } catch (e, s) {
      log.error('ERROR - fetchTokenList $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR - fetchTokenList $e',
      );
    }
  };
}

ThunkAction fetchSwapListPrices() {
  return (Store store) async {
    try {
      SwapState swapState = store.state.swapState;
      final List<Token> payWithTokens = swapState.tokens.values
          .where((Token token) =>
              num.parse(token.getBalance(true)).compareTo(0) == 1)
          .toList();
      for (Token token in payWithTokens) {
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
    } catch (e, s) {
      log.error('ERROR - fetchSwapListPrices $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR - fetchSwapListPrices $e',
      );
    }
  };
}

ThunkAction fetchSwapBalances() {
  return (Store store) async {
    try {
      SwapState swapState = store.state.swapState;
      String walletAddress = store.state.userState.walletAddress;
      if (fuseWeb3 == null) {
        throw 'web3 is empty';
      }
      for (Token token in swapState.tokens.values) {
        final BigInt balance = await fuseWeb3!.getTokenBalance(
          token.address,
          address: walletAddress,
        );
        store.dispatch(UpdateTokenBalance(
          tokenAddress: token.address,
          balance: balance,
        ));
      }
      store.dispatch(fetchSwapListPrices());
    } catch (e, s) {
      log.error('ERROR - fetchSwapBalances ${e.toString()} ${s.toString()}');
      // await Sentry.captureException(
      //   e,
      //   stackTrace: s,
      //   hint: 'ERROR - fetchSwapBalances $e',
      // );
    }
  };
}

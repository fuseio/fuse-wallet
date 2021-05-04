import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
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
    this.swappableTokens,
  });
}

class GetTokensImagesSuccess {
  final Map<String, String> tokensImages;
  GetTokensImagesSuccess({
    this.tokensImages,
  });
}

class ResetTokenList {}

ThunkAction fetchSwapList() {
  return (Store store) async {
    try {
      store.dispatch(ResetTokenList());
      final dio = getIt<Dio>();
      String address = store.state.userState.walletAddress;
      Response<String> response =
          await dio.get(UrlConstants.FUSESWAP_TOKEN_LIST);
      Map data = jsonDecode(response.data);
      Map<String, Token> tokens = Map();
      Map<String, String> tokensImages = Map();
      for (Map token in data['tokens']) {
        final BigInt balance = await fuseWeb3.getTokenBalance(
          token['address'],
          address: address,
        );
        if (!token.containsKey('isDeprecated')) {
          Token newToken = Token.fromJson({
            "originNetwork": 'mainnet',
            "amount": balance.toString(),
            "address": token['address'].toLowerCase(),
            "decimals": token['decimals'],
            "name": formatTokenName(token["name"]),
            "symbol": token['symbol'],
            "imageUrl": token['logoURI'],
          });
          await newToken.fetchTokenLatestPrice(
            onDone: (Price priceInfo) {
              newToken = newToken.copyWith(
                priceInfo: priceInfo,
              );
            },
            onError: (Object error, StackTrace stackTrace) {
              log.error(
                  'Fetch token price error for - ${newToken.name} - $error ');
            },
          );
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

import 'dart:convert';

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/models/swap_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

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
  final num? priceChange;
  final Price? priceInfo;
  final String tokenAddress;
  UpdateTokenPrices({
    this.priceInfo,
    this.priceChange,
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
      Response<String> response = await dio.get(
        'https://raw.githubusercontent.com/voltfinance/swap-default-token-list/master/build/voltage-swap-default.tokenlist.json',
      );
      Map data = jsonDecode(response.data!);
      Map<String, Token> tokens = {};
      Map<String, String> tokensImages = {};
      for (Map token in data['tokens']) {
        final String tokenAddress = token['address'].toLowerCase();
        final String name = Formatter.formatTokenName(token["name"]);
        final String symbol = token['symbol'];
        Token newToken = Token(
          amount: BigInt.zero,
          address: tokenAddress,
          decimals: token['decimals'],
          name: name,
          symbol: symbol,
          imageUrl: token['logoURI'],
        );
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
        await token.fetchLatestPrice(
          onDone: (Price priceInfo) {
            if (num.parse(token.priceInfo?.quote ?? '0')
                    .compareTo(num.parse(priceInfo.quote)) !=
                0) {
              store.dispatch(
                UpdateTokenPrices(
                  tokenAddress: token.address,
                  priceInfo: priceInfo,
                ),
              );
            }
          },
          onError: (e, s) {
            log.error(
              'ERROR - fetchLatestPrice : fetchSwapListPrices ${token.address}',
              error: e,
              stackTrace: s,
            );
          },
        );
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
        await token.fetchBalance(
          walletAddress,
          onDone: (balance) {
            if (balance.compareTo(token.amount) != 0) {
              store.dispatch(
                UpdateTokenBalance(
                  tokenAddress: token.address,
                  balance: balance,
                ),
              );
            }
          },
        );
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

ThunkAction swapHandler(
  TradeRequestBody swapRequestBody,
  Trade tradeInfo,
  VoidCallback sendSuccessCallback,
  void Function(dynamic) sendFailureCallback,
) {
  return (Store store) async {
    try {
      SwapRequestParametersData swapCallParameters =
          await chargeApi.requestParameters(swapRequestBody);
      String swapData = swapCallParameters.rawTxn['data'].replaceFirst(
        '0x',
        '',
      );
      Map<String, dynamic> response;
      final Map transactionBody = Map.from({
        "to": swapRequestBody.recipient,
        "status": 'pending',
        "isSwap": true,
        "tradeInfo": tradeInfo.toJson(),
        "metadata": tradeInfo.toJson(),
      });
      if (swapRequestBody.currencyIn == fuseToken.address) {
        log.info('Job callContract for swap');
        response = await chargeApi.callContract(
          getIt<Web3>(),
          swapRequestBody.recipient,
          swapCallParameters.rawTxn['to'],
          swapData,
          amountInWei: BigInt.parse(swapCallParameters.value),
          transactionBody: transactionBody,
          txMetadata: {
            "currencyOut": swapRequestBody.currencyOut,
          },
        );
      } else {
        log.info('Job approveTokenAndCallContract for swap');
        response = await chargeApi.approveTokenAndCallContract(
          getIt<Web3>(),
          swapRequestBody.recipient,
          swapRequestBody.currencyIn,
          swapCallParameters.rawTxn['to'],
          swapData,
          amountInWei: BigInt.parse(swapCallParameters.args.first),
          transactionBody: transactionBody,
          txMetadata: {
            "currencyOut": swapRequestBody.currencyOut,
          },
        );
      }
      sendSuccessCallback();
      String swapJobId = response['job']['_id'];
      log.info('Job $swapJobId for swap');
      Analytics.identify({
        AnalyticsProps.fundSwapping: true,
      });
      store.dispatch(
        fetchJobCall(
          swapJobId,
          (Map jobData) {
            store.dispatch(fetchSwapBalances());
            Analytics.track(
              eventName: AnalyticsEvents.swapApprove,
              properties: {
                AnalyticsProps.status: AnalyticsProps.success,
              },
            );
          },
          (dynamic failReason) {
            Analytics.track(
              eventName: AnalyticsEvents.swapApprove,
              properties: {
                AnalyticsProps.status: AnalyticsProps.failed,
                'failReason': failReason,
              },
            );
          },
        ),
      );
    } catch (error, stackTrace) {
      sendFailureCallback({'error': error, 'stackTrace': stackTrace});
    }
  };
}

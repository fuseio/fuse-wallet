import 'package:flutter/foundation.dart';

import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
class Token with _$Token implements Comparable<Token> {
  const Token._();

  @override
  int compareTo(Token? other) {
    if (other == null) return 1;
    return num.parse(getFiatBalance(true))
        .compareTo(num.parse(other.getFiatBalance(true)));
  }

  factory Token({
    required String address,
    required String name,
    required String symbol,
    required BigInt amount,
    required int decimals,
    @Default(false) bool isNative,
    String? imageUrl,
    int? timestamp,
    Price? priceInfo,
    String? communityAddress,
    @Default(TimeFrame.day) TimeFrame timeFrame,
    @Default(0) num priceChange,
    @Default([]) List<IntervalStats> intervalStats,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
  }) = _Token;

  String getBalance([withPrecision = false]) => Formatter.formatValue(
        amount,
        decimals,
        withPrecision,
      );

  String getFiatBalance([bool withPrecision = false]) => hasPriceInfo
      ? Formatter.formatValueToFiat(
          amount,
          decimals,
          double.parse(priceInfo!.quote),
          withPrecision,
        )
      : '0';

  bool get hasPriceInfo => priceInfo != null && priceInfo?.hasPriceInfo == true;

  Future<dynamic> fetchBalance(
    String accountAddress, {
    required Function(BigInt) onDone,
    Function? onError,
  }) async {
    if ([null, ''].contains(accountAddress) || [null, ''].contains(address)) {
      return;
    }
    final Function balanceFetcher =
        isNative ? getIt<Web3>().getBalance : getIt<Web3>().getTokenBalance;
    try {
      final dynamic balance = isNative
          ? await balanceFetcher(
              address: accountAddress,
            )
          : await balanceFetcher(
              address,
              address: accountAddress,
            );
      final BigInt value = isNative ? balance.getInWei : balance;
      onDone(value);
    } catch (e, s) {
      log.error(
        'Error - fetch token balance $name',
        error: e,
        stackTrace: s,
      );
      onError?.call(e, s);
      rethrow;
    }
  }

  Future<dynamic> fetchLatestPrice({
    String currency = 'usd',
    required void Function(Price) onDone,
    required Function onError,
  }) async {
    try {
      String price = await chargeApi.price(address);

      onDone(Price(currency: currency, quote: Decimal.parse(price).toString()));
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchPriceChange({
    required void Function(num) onDone,
    required Function onError,
  }) async {
    try {
      final String priceChange = await chargeApi.priceChange(address);
      onDone(num.parse(Decimal.parse(priceChange).toString()));
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchIntervalStats({
    required void Function(List<IntervalStats>) onDone,
    required Function onError,
    required TimeFrame timeFrame,
  }) async {
    try {
      final List<ChartItem> intervalStats = await chargeApi.interval(
        address,
        timeFrame,
      );
      onDone(List<IntervalStats>.from(
          intervalStats.map((e) => IntervalStats.fromJson(e.toJson()))));
    } catch (e, s) {
      onError(e, s);
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

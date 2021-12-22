import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, Web3;

part 'token.freezed.dart';
part 'token.g.dart';

@immutable
@freezed
class Token with _$Token implements Comparable<Token> {
  const Token._();

  @override
  int compareTo(Token? other) {
    if (other == null) return 1;
    return num.parse(getFiatBalance(true))
        .compareTo(num.parse(other.getFiatBalance(true)));
  }

  @JsonSerializable()
  factory Token({
    required String address,
    required String name,
    required String symbol,
    required BigInt amount,
    required int decimals,
    @Default(false) bool isNative,
    String? imageUrl,
    @JsonKey(ignore: true) String? subtitle,
    int? timestamp,
    Price? priceInfo,
    String? communityAddress,
    String? originNetwork,
    @Default(0) num priceChange,
    @JsonKey(ignore: true) @Default(0) num priceDiff,
    @JsonKey(ignore: true) @Default(0) int priceDiffLimitInDays,
    @JsonKey(ignore: true) @Default([]) List<Stats> stats,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
  }) = _Token;

  String getBalance([withPrecision = false]) => Formatter.formatValue(
        amount,
        decimals,
        withPrecision,
      );

  String getFiatBalance([bool withPrecision = false]) {
    if (num.parse(priceInfo?.quote ?? '0').compareTo(0) <= 1) {
      return Formatter.formatValueToFiat(
        amount,
        decimals,
        double.tryParse(quote) ?? 0.0,
        withPrecision,
      );
    }
    return '0';
  }

  bool get hasPriceInfo =>
      ![null, '', '0', 0, 'NaN'].contains(priceInfo?.quote);

  String get quote => priceInfo?.quoteHuman ?? '0';

  Future<dynamic> fetchBalance(
    String accountAddress, {
    required Function(BigInt) onDone,
    required Function onError,
  }) async {
    if ([null, ''].contains(accountAddress) || [null, ''].contains(address))
      return;
    if (isNative) {
      try {
        EtherAmount balance =
            await getIt<Web3>(instanceName: 'fuseWeb3').getBalance(
          address: accountAddress,
        );
        if (amount.compareTo(balance.getInWei) != 0) {
          onDone(balance.getInWei);
        }
      } catch (e, s) {
        onError(e, s);
      }
    } else {
      try {
        final BigInt balance =
            await getIt<Web3>(instanceName: 'fuseWeb3').getTokenBalance(
          address,
          address: accountAddress,
        );
        if (amount.compareTo(balance) != 0) {
          onDone(balance);
        }
      } catch (e, s) {
        onError(e, s);
      }
    }
  }

  Future<dynamic> fetchLatestPrice({
    String currency = 'usd',
    required void Function(Price) onDone,
    required Function onError,
  }) async {
    try {
      Price price = await fuseSwapService.price(address);
      onDone(price);
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchPriceChange({
    required void Function(num) onDone,
    required Function onError,
  }) async {
    try {
      final num priceChange = await fuseSwapService.priceChange(address);
      onDone(priceChange);
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchStats({
    required void Function(List<Stats>) onDone,
    required Function onError,
    String limit = '30',
  }) async {
    try {
      final List<Stats> stats = await fuseSwapService.stats(
        address,
        limit: limit,
      );
      onDone(stats);
    } catch (e, s) {
      onError(e, s);
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

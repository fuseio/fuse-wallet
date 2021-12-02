import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/common/di/di.dart';
import 'package:supervecina/models/actions/actions.dart';
import 'package:supervecina/models/cash_wallet_state.dart';
import 'package:supervecina/models/tokens/price.dart';
import 'package:supervecina/models/tokens/stats.dart';
import 'package:supervecina/services.dart';
import 'package:supervecina/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';
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
    return num.parse(getBalance(true))
        .compareTo(num.parse(other.getBalance(true)));
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

  String getBalance([withPrecision = false]) => formatValue(
        amount,
        decimals,
        withPrecision,
      );
  String getFiatBalance() {
    if (priceInfo!.quote != 'NaN') {
      return getFiatValue(
        amount,
        decimals,
        double.tryParse(priceInfo!.quote) ?? 0.0,
      );
    }
    return '0';
  }

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

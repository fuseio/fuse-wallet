import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, Web3;

part 'token.freezed.dart';
part 'token.g.dart';

@immutable
@freezed
abstract class Token implements _$Token, Comparable<Token> {
  const Token._();

  @override
  int compareTo(Token other) {
    if (other == null) return 1;
    return num.parse(this.getBalance(true))
        .compareTo(num.parse(other.getBalance(true)));
  }

  @JsonSerializable()
  factory Token({
    String address,
    String name,
    @Default(false) bool isNative,
    String symbol,
    String imageUrl,
    int decimals,
    BigInt amount,
    @JsonKey(ignore: true) String subtitle,
    int timestamp,
    Price priceInfo,
    String communityAddress,
    String originNetwork,
    num priceChange,
    List<Stats> stats,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions walletActions,
  }) = _Token;

  String getBalance([withPrecision = false]) => formatValue(
        amount,
        decimals,
        withPrecision: withPrecision,
      );
  String getFiatBalance() {
    if (priceInfo != null && priceInfo?.quote != 'NaN') {
      return getFiatValue(
        amount,
        decimals,
        double.tryParse(priceInfo?.quote) ?? 0.0,
      );
    }
    return '0';
  }

  Future<dynamic> fetchBalance(
    String accountAddress, {
    Function(BigInt) onDone,
    Function onError,
  }) async {
    if ([null, ''].contains(accountAddress) || [null, ''].contains(address))
      return;
    if (isNative != null && isNative == true) {
      Web3 web3 = originNetwork == 'fuse' ? fuseWeb3 : ethereumWeb3;
      try {
        EtherAmount balance = await web3.getBalance(
          address: accountAddress,
        );
        if (amount?.compareTo(balance.getInWei) != 0) {
          onDone(balance.getInWei);
        }
      } catch (e, s) {
        onError(e, s);
      }
    } else {
      try {
        Web3 web3 = originNetwork == null ? ethereumWeb3 : fuseWeb3;
        final BigInt balance = await web3.getTokenBalance(
          address,
          address: accountAddress,
        );
        if (amount?.compareTo(balance) != 0) {
          onDone(balance);
        }
      } catch (e, s) {
        onError(e, s);
      }
    }
  }

  Future<dynamic> fetchLatestPrice({
    String currency = 'usd',
    void Function(Price) onDone,
    Function onError,
  }) async {
    try {
      Price price = await fuseSwapService.price(address);
      onDone(price);
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchPriceChange({
    void Function(num) onDone,
    Function onError,
  }) async {
    try {
      final num priceChange = await fuseSwapService.priceChange(address);
      onDone(priceChange);
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchStats({
    void Function(List<Stats>) onDone,
    Function onError,
  }) async {
    try {
      final List<Stats> stats = await fuseSwapService.stats(address);
      onDone(stats);
    } catch (e, s) {
      onError(e, s);
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

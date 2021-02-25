import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/services/apis/market.dart';
import 'package:fusecash/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

Transactions transactionsFromJson(Map<String, dynamic> json) =>
    json == null ? Transactions.initial() : Transactions.fromJson(json);

@immutable
@freezed
abstract class Token implements _$Token {
  const Token._();

  @JsonSerializable()
  factory Token({
    String address,
    String name,
    String symbol,
    String imageUrl,
    int decimals,
    BigInt amount,
    @JsonKey(ignore: true) String subtitle,
    int timestamp,
    Price priceInfo,
    @JsonKey(fromJson: transactionsFromJson) Transactions transactions,
    String communityAddress,
    String originNetwork,
  }) = _Token;

  String getBalance() => formatValue(amount, decimals);

  Future<dynamic> fetchTokenBalance(
    String accountAddress, {
    Function(BigInt) onDone,
    Function onError,
  }) async {
    if ([null, ''].contains(accountAddress) ||
        [null, ''].contains(this.address)) return;
    if (originNetwork == null) {
      try {
        final BigInt balance = await ethereumWeb3.getTokenBalance(
          this.address,
          address: accountAddress,
        );
        if (this.amount?.compareTo(balance) != 0) {
          onDone(balance);
        }
      } catch (e, s) {
        onError(e, s);
      }
    } else {
      try {
        final BigInt balance = await fuseWeb3.getTokenBalance(
          this.address,
          address: accountAddress,
        );
        if (this.amount?.compareTo(balance) != 0) {
          onDone(balance);
        }
      } catch (e, s) {
        onError(e, s);
      }
    }
  }

  Future<dynamic> fetchTokenLastestPrice({
    String currency = 'usd',
    void Function(Price) onDone,
    Function onError,
  }) async {
    try {
      Market marketApi = getIt<Market>();
      Map<String, dynamic> response = await marketApi.getCurrentPriceOfTokens(
        this.address,
        currency,
      );
      double price = response[this.address.toLowerCase()][currency];
      String quote = response[this.address.toLowerCase()][currency].toString();
      String total = getFiatValue(
        this.amount,
        this.decimals,
        price,
        withPrecision: true,
      );
      if (this.priceInfo == null) {
        Price priceInfo = Price(
          currency: currency,
          quote: quote,
          total: total,
        );
        onDone(priceInfo);
      } else {
        Price priceInfo = this.priceInfo.copyWith(
              quote: quote,
              currency: currency,
              total: total,
            );
        onDone(priceInfo);
      }
    } catch (e, s) {
      onError(e, s);
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

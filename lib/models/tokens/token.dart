import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, Web3;

part 'token.freezed.dart';
part 'token.g.dart';

@immutable
@freezed
abstract class Token implements _$Token {
  const Token._();

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
    @JsonKey(fromJson: walletActionsFromJson) WalletActions walletActions,
  }) = _Token;

  String getBalance() => formatValue(amount, decimals);

  Future<dynamic> fetchTokenBalance(
    String accountAddress, {
    Function(BigInt) onDone,
    Function onError,
  }) async {
    if ([null, ''].contains(accountAddress) ||
        [null, ''].contains(this.address)) return;
    if (this.isNative != null && this.isNative == true) {
      Web3 web3 = this.originNetwork == 'fuse' ? fuseWeb3 : ethereumWeb3;
      try {
        EtherAmount balance = await web3.getBalance(
          address: accountAddress,
        );
        if (this.amount?.compareTo(balance.getInWei) != 0) {
          onDone(balance.getInWei);
        }
      } catch (e, s) {
        onError(e, s);
      }
    } else {
      try {
        Web3 web3 = originNetwork == null ? ethereumWeb3 : fuseWeb3;
        final BigInt balance = await web3.getTokenBalance(
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

  Future<dynamic> fetchTokenLatestPrice({
    String currency = 'usd',
    void Function(Price) onDone,
    Function onError,
  }) async {
    try {
      Price price = await fuseSwapService.price(this.address);
      String total = getFiatValue(
        this.amount,
        this.decimals,
        double.parse(price.quote),
        withPrecision: true,
      );
      onDone(price.copyWith(
        total: total,
      ));
    } catch (e, s) {
      onError(e, s);
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

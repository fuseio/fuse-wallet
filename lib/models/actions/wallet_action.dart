import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/utils/format.dart';

part 'wallet_action.freezed.dart';
part 'wallet_action.g.dart';

@immutable
@freezed
class WalletAction with _$WalletAction {
  const WalletAction._();

  factory WalletAction.fromJson(dynamic json) => _$WalletActionFromJson(json);

  bool isPending() => this.status == 'PENDING' || this.status == 'STARTED';
  bool isFailed() => this.status == 'FAILED';
  bool isConfirmed() =>
      this.status == 'CONFIRMED' || this.status == 'SUCCEEDED';

  String getAmount({Price? priceInfo}) {
    return this.map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) =>
          calcPrice(value.value, value.tokenDecimal, priceInfo),
      bonus: (value) => calcPrice(value.value, value.tokenDecimal, priceInfo),
      send: (value) => calcPrice(value.value, value.tokenDecimal, priceInfo),
      receive: (value) => calcPrice(value.value, value.tokenDecimal, priceInfo),
      swap: (value) {
        final bool hasPriceInfo =
            ![null, '', '0', 0, 'NaN'].contains(priceInfo?.quote);
        if (hasPriceInfo) {
          double a = double.parse(value.tradeInfo!.outputAmount) *
              double.parse(priceInfo!.quote);
          return display(num.tryParse(a.toString()));
        }
        return display(num.parse(value.tradeInfo!.outputAmount));
      },
    );
  }

  bool isGenerateWallet() {
    return this.map(
      createWallet: (value) => true,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
      swap: (value) => false,
    );
  }

  bool isSwapAction() {
    return this.map(
      createWallet: (value) => false,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
      swap: (value) => true,
    );
  }

  bool isJoinBonus() {
    return this.map(
      createWallet: (value) => false,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => true,
      send: (value) => false,
      receive: (value) => false,
      swap: (value) => false,
    );
  }

  bool isJoinCommunity() {
    return this.map(
      createWallet: (value) => false,
      joinCommunity: (value) => true,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
      swap: (value) => false,
    );
  }

  Widget getActionIcon() {
    if (this.isFailed()) {
      return SvgPicture.asset(
        'assets/images/failed_icon.svg',
        height: 9,
      );
    }
    return this.map(
      createWallet: (value) => Text(''),
      joinCommunity: (value) => Text(''),
      fiatDeposit: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        height: 14,
      ),
      bonus: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        height: 14,
      ),
      send: (value) => SvgPicture.asset(
        'assets/images/send_icon.svg',
        height: 14,
      ),
      receive: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        height: 14,
      ),
      swap: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        height: 14,
      ),
    );
  }

  Widget getStatusIcon() {
    if (this.isFailed()) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/failed_icon.svg',
          width: 25,
          height: 25,
        ),
      );
    } else if (this.isConfirmed()) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/approve_icon.svg',
          width: 25,
          height: 25,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/pending.svg',
          width: 25,
          height: 25,
        ),
      );
    }
  }

  String getText(BuildContext context) {
    return this.map(
      createWallet: (value) {
        if (value.isFailed()) {
          return I10n.of(context).generate_wallet_failed;
        } else if (value.isConfirmed()) {
          return I10n.of(context).generated_wallet;
        } else {
          return I10n.of(context).generating_wallet;
        }
      },
      joinCommunity: (value) => value.communityName!,
      fiatDeposit: (value) {
        if (value.isFailed()) {
          return 'fUSD - ${I10n.of(context).deposit_failed}';
        } else if (value.isConfirmed()) {
          return 'fUSD - ${I10n.of(context).deposit}';
        } else {
          return I10n.of(context).waiting_for_deposit;
        }
      },
      bonus: (value) {
        if (value.isFailed()) {
          return '${I10n.of(context).receiving} ${value.bonusType} ${I10n.of(context).bonus} failed';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).you_got_a} ${value.bonusType} ${I10n.of(context).bonus}!';
        } else {
          return '${I10n.of(context).you_got_a} ${value.bonusType} ${I10n.of(context).bonus}';
        }
      },
      send: (value) {
        if (value.isFailed()) {
          return '${I10n.of(context).send_to} ${formatAddress(value.to)} ${I10n.of(context).failed.toLowerCase()}';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).send_to} ${formatAddress(value.to)} ${I10n.of(context).success.toLowerCase()}';
        } else {
          return '${I10n.of(context).send_to} ${formatAddress(value.to)} ${I10n.of(context).success.toLowerCase()}';
        }
      },
      receive: (value) {
        if (value.isFailed()) {
          return '${I10n.of(context).receive_from} ${formatAddress(value.from)}  ${I10n.of(context).failed.toLowerCase()}';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).receive_from} ${formatAddress(value.from)} ${I10n.of(context).success.toLowerCase()}';
        } else {
          return '${I10n.of(context).receive_from} ${formatAddress(value.from)} ${I10n.of(context).success.toLowerCase()}';
        }
      },
      swap: (value) {
        final String text = value.tradeInfo!.inputToken +
            I10n.of(context).for_text +
            ' ${value.tradeInfo!.outputToken}';
        return text;
      },
    );
  }

  String getSender() {
    return this.map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => value.from ?? '',
      bonus: (value) => value.from ?? '',
      send: (value) => value.to,
      receive: (value) => value.from ?? '',
      swap: (value) => '',
    );
  }

  String getRecipient() {
    return this.map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => value.to,
      bonus: (value) => value.to,
      send: (value) => value.to,
      receive: (value) => value.to,
      swap: (value) => '',
    );
  }

  @JsonSerializable()
  const factory WalletAction.createWallet({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('createWallet') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
  }) = CreateWallet;

  @JsonSerializable()
  const factory WalletAction.fiatDeposit({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('fiat-deposit') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    @Default(null) String? from,
    required String to,
    required BigInt value,
    String? tokenName,
    String? tokenSymbol,
    @Default(18) int tokenDecimal,
  }) = FiatDeposit;

  @JsonSerializable()
  const factory WalletAction.joinCommunity({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('joinCommunity') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    String? communityAddress,
    String? tokenAddress,
    @Default(null) String? communityName,
  }) = JoinCommunity;

  @JsonSerializable()
  const factory WalletAction.bonus({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('tokenBonus') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    @Default(null) String? from,
    required String to,
    required BigInt value,
    String? tokenName,
    String? tokenSymbol,
    @Default(18) int tokenDecimal,
    String? bonusType,
  }) = Bonus;

  @JsonSerializable()
  const factory WalletAction.send({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('sendTokens') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    @Default(null) String? from,
    required String to,
    required BigInt value,
    String? tokenName,
    String? tokenSymbol,
    @Default(18) int tokenDecimal,
  }) = Send;

  @JsonSerializable()
  const factory WalletAction.receive({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('receiveTokens') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    @Default(null) String? from,
    required String to,
    required BigInt value,
    String? tokenName,
    String? tokenSymbol,
    @Default(18) int tokenDecimal,
  }) = Receive;

  @JsonSerializable()
  const factory WalletAction.swap({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('swapTokens') String name,
    @Default(null) String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    @Default(null) @JsonKey(name: 'metadata') TradeInfo? tradeInfo,
  }) = Swap;
}

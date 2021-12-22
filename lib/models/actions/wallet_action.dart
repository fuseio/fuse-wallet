import 'package:decimal/decimal.dart';
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
class WalletAction with _$WalletAction implements Comparable<WalletAction> {
  const WalletAction._();

  @override
  int compareTo(WalletAction? other) {
    if (other == null) return 1;
    return timestamp.compareTo(other.timestamp);
  }

  factory WalletAction.fromJson(dynamic json) => _$WalletActionFromJson(json);

  bool isPending() => status == 'PENDING' || status == 'STARTED';
  bool isFailed() => status == 'FAILED';
  bool isConfirmed() => status == 'CONFIRMED' || status == 'SUCCEEDED';

  String getName(
    BuildContext context,
  ) {
    return map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => I10n.of(context).action_fiatDeposit,
      bonus: (value) => I10n.of(context).action_bonus,
      send: (value) => I10n.of(context).action_send,
      receive: (value) => I10n.of(context).action_receive,
      swap: (value) => I10n.of(context).action_swap,
    );
  }

  String getAmount([Price? priceInfo]) {
    return map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      bonus: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      send: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      receive: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      swap: (value) {
        final bool hasPriceInfo =
            ![null, '', '0', 0, 'NaN'].contains(priceInfo?.quote);
        if (hasPriceInfo) {
          Decimal temp = Decimal.parse(value.tradeInfo!.outputAmount) *
              Decimal.parse(priceInfo!.quote);
          if (Formatter.isSmallThan(Decimal.parse(temp.toString()))) {
            return '\$' + display6(temp.toDouble());
          } else {
            return '\$' + display2(temp.toDouble());
          }
        }
        return display2(num.parse(value.tradeInfo?.outputAmount ?? '0'));
      },
    );
  }

  bool isGenerateWallet() {
    return map(
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
    return map(
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
    return map(
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
    return map(
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
    if (isFailed()) {
      return SvgPicture.asset(
        'assets/images/failed_icon.svg',
        height: 9,
      );
    }
    return map(
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

  Widget getStatusIcon([
    double? width = 25,
    double? height = 25,
  ]) {
    if (isFailed()) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/failed_icon.svg',
          width: width,
          height: height,
        ),
      );
    } else if (isConfirmed()) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/approve_icon.svg',
          width: width,
          height: height,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/pending.svg',
          width: width,
          height: height,
        ),
      );
    }
  }

  String getText(
    BuildContext context, {
    String? displayName,
  }) {
    return map(
      createWallet: (value) {
        if (value.isFailed()) {
          return I10n.of(context).generate_wallet_failed;
        } else if (value.isConfirmed()) {
          return I10n.of(context).generated_wallet;
        } else {
          return I10n.of(context).generating_wallet;
        }
      },
      joinCommunity: (value) => value.communityName ?? 'Fuse Dollar',
      fiatDeposit: (value) {
        if (value.isFailed()) {
          return 'fUSD - ${I10n.of(context).deposit_failed}';
        } else if (value.isConfirmed()) {
          return I10n.of(context).deposit;
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
        final name = displayName ?? Formatter.formatEthAddress(value.to);
        if (value.isFailed()) {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        } else {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        }
      },
      receive: (value) {
        final name = displayName ?? Formatter.formatEthAddress(value.to);
        if (value.isFailed()) {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
        } else {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
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
    return map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => value.from ?? '',
      bonus: (value) => value.from ?? '',
      send: (value) => value.to,
      receive: (value) => value.from,
      swap: (value) => '',
    );
  }

  String getRecipient() {
    return map(
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
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
  }) = CreateWallet;

  @JsonSerializable()
  const factory WalletAction.fiatDeposit({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('fiat-deposit') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    String? from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
  }) = FiatDeposit;

  @JsonSerializable()
  const factory WalletAction.joinCommunity({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('joinCommunity') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    String? communityAddress,
    required String tokenAddress,
    String? communityName,
  }) = JoinCommunity;

  @JsonSerializable()
  const factory WalletAction.bonus({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('tokenBonus') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    String? from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
    String? bonusType,
  }) = Bonus;

  @JsonSerializable()
  const factory WalletAction.send({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('sendTokens') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    required String from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
  }) = Send;

  @JsonSerializable()
  const factory WalletAction.receive({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('receiveTokens') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    required String tokenAddress,
    required String from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
  }) = Receive;

  @JsonSerializable()
  const factory WalletAction.swap({
    @Default(0) int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('swapTokens') String name,
    String? txHash,
    required String status,
    @Default(0) int? blockNumber,
    @JsonKey(name: 'metadata') TradeInfo? tradeInfo,
  }) = Swap;
}

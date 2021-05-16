import 'package:auto_route/auto_route.dart';
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

  String getText() {
    return '';
    // return this.map(
    //   createWallet: (value) {
    //     if (value.isFailed()) {
    //       return I10n.of(ExtendedNavigator.root.context).generate_wallet_failed;
    //     } else if (value.isConfirmed()) {
    //       return I10n.of(ExtendedNavigator.root.context).generated_wallet;
    //     } else {
    //       return I10n.of(ExtendedNavigator.root.context).generating_wallet;
    //     }
    //   },
    //   joinCommunity: (value) => value.communityName,
    //   fiatDeposit: (value) {
    //     if (value.isFailed()) {
    //       return 'fUSD - ${I10n.of(ExtendedNavigator.root.context).deposit_failed}';
    //     } else if (value.isConfirmed()) {
    //       return 'fUSD - ${I10n.of(ExtendedNavigator.root.context).deposit}';
    //     } else {
    //       return I10n.of(ExtendedNavigator.root.context).waiting_for_deposit;
    //     }
    //   },
    //   bonus: (value) {
    //     if (value.isFailed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).receiving} ${value.bonusType} ${I10n.of(ExtendedNavigator.root.context).bonus} failed';
    //     } else if (value.isConfirmed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).you_got_a} ${value.bonusType} ${I10n.of(ExtendedNavigator.root.context).bonus}';
    //     } else {
    //       return '${I10n.of(ExtendedNavigator.root.context).you_got_a} ${value.bonusType} ${I10n.of(ExtendedNavigator.root.context).bonus}';
    //     }
    //   },
    //   send: (value) {
    //     if (value.isFailed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).send_to} ${formatAddress(value.to)} ${I10n.of(ExtendedNavigator.root.context).failed.toLowerCase()}';
    //     } else if (value.isConfirmed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).send_to} ${formatAddress(value.to)} ${I10n.of(ExtendedNavigator.root.context).success.toLowerCase()}';
    //     } else {
    //       return '${I10n.of(ExtendedNavigator.root.context).send_to} ${formatAddress(value.to)} ${I10n.of(ExtendedNavigator.root.context).success.toLowerCase()}';
    //     }
    //   },
    //   receive: (value) {
    //     if (value.isFailed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).receive_from} ${formatAddress(value.from)}  ${I10n.of(ExtendedNavigator.root.context).failed.toLowerCase()}';
    //     } else if (value.isConfirmed()) {
    //       return '${I10n.of(ExtendedNavigator.root.context).receive_from} ${formatAddress(value.from)} ${I10n.of(ExtendedNavigator.root.context).success.toLowerCase()}';
    //     } else {
    //       return '${I10n.of(ExtendedNavigator.root.context).receive_from} ${formatAddress(value.from)} ${I10n.of(ExtendedNavigator.root.context).success.toLowerCase()}';
    //     }
    //   },
    //   swap: (value) {
    //     final String text = value.tradeInfo.inputToken +
    //         I10n.of(ExtendedNavigator.root.context).for_text +
    //         ' ${value.tradeInfo.outputToken}';
    //     return text;
    //   },
    // );
  }

  String getSender() {
    return this.map(
      createWallet: (value) => '',
      joinCommunity: (value) => '',
      fiatDeposit: (value) => value.from,
      bonus: (value) => value.from,
      send: (value) => value.to,
      receive: (value) => value.from,
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

  // @override
  // int get timestamp;

  @JsonSerializable()
  const factory WalletAction.createWallet({
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('createWallet') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
  }) = CreateWallet;

  @JsonSerializable()
  const factory WalletAction.fiatDeposit({
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('fiat-deposit') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
    required String tokenAddress,
    required String from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
  }) = FiatDeposit;

  @JsonSerializable()
  const factory WalletAction.joinCommunity({
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('joinCommunity') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
    required String communityAddress,
    required String tokenAddress,
    @Default(null) String? communityName,
  }) = JoinCommunity;

  @JsonSerializable()
  const factory WalletAction.bonus({
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('tokenBonus') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
    required String tokenAddress,
    required String from,
    required String to,
    required BigInt value,
    required String tokenName,
    required String tokenSymbol,
    required int tokenDecimal,
    @Default(null) String? bonusType,
  }) = Bonus;

  @JsonSerializable()
  const factory WalletAction.send({
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('sendTokens') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
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
    required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('receiveTokens') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
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
    @Default(null) required int timestamp,
    @JsonKey(name: '_id') required String id,
    @Default('swapTokens') required String name,
    @Default(null) String? txHash,
    required String status,
    required int blockNumber,
    @Default(null) @JsonKey(name: 'metadata') TradeInfo? tradeInfo,
  }) = Swap;
}

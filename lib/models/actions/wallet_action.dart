import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/utils/format.dart';

part 'wallet_action.freezed.dart';
part 'wallet_action.g.dart';

@immutable
@freezed
abstract class WalletAction implements _$WalletAction {
  const WalletAction._();

  factory WalletAction.fromJson(dynamic json) => _$WalletActionFromJson(json);

  bool isPending() => this.status == 'PENDING' || this.status == 'STARTED';
  bool isFailed() => this.status == 'FAILED';
  bool isConfirmed() =>
      this.status == 'CONFIRMED' || this.status == 'SUCCEEDED';

  String getAmount() {
    return this.map(
      createWallet: (value) => '',
      fiatProcess: (value) => '',
      fiatDeposit: (value) => '',
      joinCommunity: (value) => '',
      bonus: (value) => formatValue(value?.value, value.tokenDecimal),
      send: (value) => formatValue(value?.value, value.tokenDecimal),
      receive: (value) => formatValue(value?.value, value.tokenDecimal),
    );
  }

  bool isGenerateWallet() {
    return this.map(
      createWallet: (value) => true,
      fiatProcess: (value) => false,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
    );
  }

  bool isJoinBonus() {
    return this.map(
      createWallet: (value) => false,
      fiatProcess: (value) => false,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => true,
      send: (value) => false,
      receive: (value) => false,
    );
  }

  bool isJoinCommunity() {
    return this.map(
      createWallet: (value) => false,
      fiatProcess: (value) => false,
      joinCommunity: (value) => true,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
    );
  }

  bool isFiatProccesing() {
    return this.map(
      createWallet: (value) => false,
      fiatProcess: (value) => true,
      joinCommunity: (value) => false,
      fiatDeposit: (value) => false,
      bonus: (value) => false,
      send: (value) => false,
      receive: (value) => false,
    );
  }

  Widget getActionIcon() {
    if (this.isFailed()) {
      return SvgPicture.asset(
        'assets/images/failed_icon.svg',
        width: 10,
        height: 10,
      );
    }
    return this.map(
      createWallet: (value) => null,
      fiatProcess: (value) => null,
      joinCommunity: (value) => null,
      fiatDeposit: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        width: 10,
        height: 10,
      ),
      bonus: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        width: 10,
        height: 10,
      ),
      send: (value) => SvgPicture.asset(
        'assets/images/send_icon.svg',
        width: 10,
        height: 10,
      ),
      receive: (value) => SvgPicture.asset(
        'assets/images/receive_icon.svg',
        width: 10,
        height: 10,
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
    return this.map(
      createWallet: (value) {
        if (value.isFailed()) {
          return I18n.of(ExtendedNavigator.root.context).generate_wallet_failed;
        } else if (value.isConfirmed()) {
          return I18n.of(ExtendedNavigator.root.context).generated_wallet;
        } else {
          return I18n.of(ExtendedNavigator.root.context).generating_wallet;
        }
      },
      fiatProcess: (value) {
        if (value.isFailed()) {
          return 'Payment faild';
        } else if (value.isConfirmed()) {
          return 'Payment Done';
        } else {
          return 'Waiting for payment';
        }
      },
      joinCommunity: (value) => value.communityName,
      fiatDeposit: (value) {
        if (value.isFailed()) {
          return 'FUSD - deposit failed';
        } else if (value.isConfirmed()) {
          return 'FUSD - deposit';
        } else {
          return 'Waiting for your deposit to arrive';
        }
      },
      bonus: (value) {
        if (value.isFailed()) {
          return 'Receiving ${value.bonusType} ${I18n.of(ExtendedNavigator.root.context).bonus} failed';
        } else if (value.isConfirmed()) {
          return '${I18n.of(ExtendedNavigator.root.context).you_got_a} ${value.bonusType} ${I18n.of(ExtendedNavigator.root.context).bonus}';
        } else {
          return '${I18n.of(ExtendedNavigator.root.context).you_got_a} ${value.bonusType} ${I18n.of(ExtendedNavigator.root.context).bonus}';
        }
      },
      send: (value) {
        if (value.isFailed()) {
          return 'Send to ${formatAddress(value.to)} failed';
        } else if (value.isConfirmed()) {
          return 'Send to ${formatAddress(value.to)} success';
        } else {
          return 'Send to ${formatAddress(value.to)} pending';
        }
      },
      receive: (value) {
        if (value.isFailed()) {
          return 'Receive from ${formatAddress(value.from)} failed';
        } else if (value.isConfirmed()) {
          return 'Receive from ${formatAddress(value.from)} success';
        } else {
          return 'Receive from ${formatAddress(value.from)} pending';
        }
      },
    );
  }

  @JsonSerializable()
  const factory WalletAction.createWallet({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
  }) = CreateWallet;

  @JsonSerializable()
  const factory WalletAction.fiatProcess({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String tokenAddress,
    String from,
    String to,
    BigInt value,
    String tokenName,
    String tokenSymbol,
    int tokenDecimal,
  }) = FiatProcess;

  @JsonSerializable()
  const factory WalletAction.fiatDeposit({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String tokenAddress,
    String from,
    String to,
    BigInt value,
    String tokenSymbol,
    String tokenName,
    int tokenDecimal,
  }) = FiatDeposit;

  @JsonSerializable()
  const factory WalletAction.joinCommunity({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String communityAddress,
    String tokenAddress,
    String communityName,
  }) = JoinCommunity;

  @JsonSerializable()
  const factory WalletAction.bonus({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String tokenAddress,
    String from,
    String to,
    BigInt value,
    String tokenName,
    String tokenSymbol,
    int tokenDecimal,
    String bonusType,
  }) = Bonus;

  @JsonSerializable()
  const factory WalletAction.send({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String tokenAddress,
    String from,
    String to,
    BigInt value,
    String tokenName,
    String tokenSymbol,
    int tokenDecimal,
  }) = Send;

  @JsonSerializable()
  const factory WalletAction.receive({
    int timestamp,
    String name,
    String txHash,
    String status,
    int blockNumber,
    String tokenAddress,
    String from,
    String to,
    BigInt value,
    String tokenName,
    String tokenSymbol,
    int tokenDecimal,
  }) = Receive;
}

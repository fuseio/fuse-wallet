import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';
part 'actions.g.dart';

List<WalletAction> listFromJson(Map<String, dynamic> json) => json == null
    ? <WalletAction>[]
    : List<WalletAction>.from(
        json['list'].map((job) => WalletActionFactory.fromJson(job)));

Map<String, dynamic> listToJson(List<dynamic> list) =>
    new Map.from({"list": list.map((action) => action.toJson()).toList()});

@immutable
@freezed
abstract class WalletActions implements _$WalletActions {
  @JsonSerializable()
  factory WalletActions({
    @JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
        List<WalletAction> list,
    @Default(0) num updatedAt,
  }) = _WalletActions;

  factory WalletActions.initial() {
    return WalletActions(
      updatedAt: 0,
      list: <WalletAction>[],
    );
  }

  factory WalletActions.fromJson(Map<String, dynamic> json) =>
      _$WalletActionsFromJson(json);
}

class WalletActionFactory {
  static WalletAction fromJson(Map<String, dynamic> json) {
    if (json['name'] == 'createWallet') {
      return CreateWallet.fromJson(json);
    } else if (json['name'] == 'tokenBonus') {
      return Bonus.fromJson(json);
    } else if (json['name'] == 'joinCommunity') {
      return JoinCommunity.fromJson(json);
    } else if (json['name'] == 'sendTokens') {
      return Send.fromJson(json);
    } else if (json['name'] == 'fiat-processing') {
      return FiatProcess.fromJson(json);
    } else if (json['name'] == 'fiat-deposit') {
      return FiatDeposit.fromJson(json);
    } else if (json['name'] == 'receiveTokens') {
      return Receive.fromJson(json);
    } else {
      return Receive.fromJson(json);
    }
  }
}

import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';
part 'actions.g.dart';

@immutable
@freezed
abstract class WalletActions implements _$WalletActions {
  @JsonSerializable()
  factory WalletActions({
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
  static WalletAction create(Map<String, dynamic> json) {
    json =
        json.containsKey('data') ? Map.from({...json, ...json['data']}) : json;
    json['timestamp'] =
        DateTime.parse(json['updatedAt']).millisecondsSinceEpoch;
    json['value'] =
        json.containsKey('value') && [null, '', 'NaN'].contains(json['value'])
            ? '0'
            : json['value'];
    json['status'] = json['status']?.toUpperCase();
    if (json['name'] == 'createWallet') {
      return CreateWallet.fromJson(json);
    } else if (json['name'] == 'swapTokens') {
      return Swap.fromJson(json);
    } else if (json['name'] == 'tokenBonus') {
      return Bonus.fromJson(json);
    } else if (json['name'] == 'joinCommunity') {
      return JoinCommunity.fromJson(json);
    } else if (json['name'] == 'sendTokens') {
      return Send.fromJson(json);
    } else if (json['name'] == 'fiat-deposit') {
      return FiatDeposit.fromJson(json);
    } else if (json['name'] == 'receiveTokens') {
      return Receive.fromJson(json);
    } else {
      return Receive.fromJson(json);
    }
  }

  static List<WalletAction> actionsFromJson(Iterable<dynamic> docs) =>
      List<WalletAction>.from(docs.map(
        (json) => WalletActionFactory.create(json),
      ));
}

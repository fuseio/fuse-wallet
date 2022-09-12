

import 'package:charge_wallet_sdk/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class NftsState with _$NftsState {
  factory NftsState({
    @Default({}) Map<String, Map<int, Collectible>> collectibles,
  }) = _NftsState;

  factory NftsState.fromJson(dynamic json) => _$NftsStateFromJson(json);
}

class NftsStateConverter
    implements JsonConverter<NftsState, Map<String, dynamic>?> {
  const NftsStateConverter();

  @override
  NftsState fromJson(Map<String, dynamic>? json) =>
      json != null ? NftsState.fromJson(json) : NftsState();

  @override
  Map<String, dynamic> toJson(NftsState instance) => instance.toJson();
}

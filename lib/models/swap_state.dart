import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'swap_state.freezed.dart';
part 'swap_state.g.dart';

@immutable
@freezed
abstract class SwapState implements _$SwapState {
  const SwapState._();

  @JsonSerializable()
  factory SwapState({
    @JsonKey(ignore: true) @Default([]) List<Token> tokensList,
  }) = _SwapState;

  factory SwapState.fromJson(dynamic json) => _$SwapStateFromJson(json);
}

class SwapStateConverter
    implements JsonConverter<SwapState, Map<String, dynamic>> {
  const SwapStateConverter();

  @override
  SwapState fromJson(Map<String, dynamic> json) =>
      json != null ? SwapState.fromJson(json) : SwapState(tokensList: []);

  @override
  Map<String, dynamic> toJson(SwapState instance) => instance?.toJson();
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'swap_state.freezed.dart';
part 'swap_state.g.dart';

@immutable
@freezed
class SwapState with _$SwapState {
  const SwapState._();

  @JsonSerializable()
  factory SwapState({
    @JsonKey(ignore: true) @Default({}) Map<String, Token> tokens,
    @Default({}) Map<String, String> tokensImages,
  }) = _SwapState;

  factory SwapState.fromJson(dynamic json) => _$SwapStateFromJson(json);
}

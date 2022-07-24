import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/tokens/token.dart';

part 'swap_state.freezed.dart';
part 'swap_state.g.dart';

Map<String, Token> tokensFromJson(Map<String, dynamic> tokens) => tokens.map(
      (k, e) {
        if (k == Addresses.zeroAddress) {
          return MapEntry(
            Addresses.nativeTokenAddress,
            Token.fromJson(
              {
                ...e as Map<String, dynamic>,
                'address': Addresses.nativeTokenAddress,
              },
            ),
          );
        } else {
          return MapEntry(
            k,
            Token.fromJson(
              e as Map<String, dynamic>,
            ),
          );
        }
      },
    );

@freezed
class SwapState with _$SwapState {
  const SwapState._();

  factory SwapState({
    @JsonKey(fromJson: tokensFromJson) @Default({}) Map<String, Token> tokens,
    @Default({}) Map<String, String> tokensImages,
    @JsonKey(ignore: true) @Default(false) bool isFetching,
  }) = _SwapState;

  factory SwapState.initial() {
    return SwapState(
      tokens: const {},
      tokensImages: const {},
    );
  }

  factory SwapState.fromJson(dynamic json) => _$SwapStateFromJson(json);
}

class SwapStateConverter
    implements JsonConverter<SwapState, Map<String, dynamic>?> {
  const SwapStateConverter();

  @override
  SwapState fromJson(Map<String, dynamic>? json) =>
      json != null ? SwapState.fromJson(json) : SwapState.initial();

  @override
  Map<String, dynamic> toJson(SwapState instance) => instance.toJson();
}

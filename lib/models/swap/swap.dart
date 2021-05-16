import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'swap.freezed.dart';
part 'swap.g.dart';

@immutable
@freezed
class TradeInfo with _$TradeInfo {
  @JsonSerializable()
  factory TradeInfo(
    String inputAmount,
    String outputAmount,
    List<String> route,
    String inputToken,
    String outputToken,
    String executionPrice,
    String nextMidPrice,
    String priceImpact,
  ) = _TradeInfo;

  factory TradeInfo.fromJson(Map<String, dynamic> json) =>
      _$TradeInfoFromJson(json);
}

@immutable
@freezed
class SwapCallParameters with _$SwapCallParameters {
  @JsonSerializable()
  factory SwapCallParameters(
    String methodName,
    List<dynamic> args,
    String value,
    Map<String, dynamic> rawTxn,
  ) = _SwapCallParameters;

  factory SwapCallParameters.fromJson(Map<String, dynamic> json) =>
      _$SwapCallParametersFromJson(json);
}

@immutable
@freezed
class SwapRequestBody with _$SwapRequestBody {
  @JsonSerializable()
  factory SwapRequestBody({
    @Default('') String currencyIn,
    @Default('') String currencyOut,
    @Default('') String amountIn,
    @Default('') String recipient,
  }) = _SwapRequestBody;

  factory SwapRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SwapRequestBodyFromJson(json);
}

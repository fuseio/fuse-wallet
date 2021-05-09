// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TradeInfo _$_$_TradeInfoFromJson(Map<String, dynamic> json) {
  return _$_TradeInfo(
    json['inputAmount'] as String,
    json['outputAmount'] as String,
    (json['route'] as List<dynamic>).map((e) => e as String).toList(),
    json['inputToken'] as String,
    json['outputToken'] as String,
    json['executionPrice'] as String,
    json['nextMidPrice'] as String,
    json['priceImpact'] as String,
  );
}

Map<String, dynamic> _$_$_TradeInfoToJson(_$_TradeInfo instance) =>
    <String, dynamic>{
      'inputAmount': instance.inputAmount,
      'outputAmount': instance.outputAmount,
      'route': instance.route,
      'inputToken': instance.inputToken,
      'outputToken': instance.outputToken,
      'executionPrice': instance.executionPrice,
      'nextMidPrice': instance.nextMidPrice,
      'priceImpact': instance.priceImpact,
    };

_$_SwapCallParameters _$_$_SwapCallParametersFromJson(
    Map<String, dynamic> json) {
  return _$_SwapCallParameters(
    json['methodName'] as String,
    json['args'] as List<dynamic>,
    json['value'] as String,
    json['rawTxn'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$_$_SwapCallParametersToJson(
        _$_SwapCallParameters instance) =>
    <String, dynamic>{
      'methodName': instance.methodName,
      'args': instance.args,
      'value': instance.value,
      'rawTxn': instance.rawTxn,
    };

_$_SwapRequestBody _$_$_SwapRequestBodyFromJson(Map<String, dynamic> json) {
  return _$_SwapRequestBody(
    json['currencyIn'] as String,
    json['currencyOut'] as String,
    json['amountIn'] as String,
    json['recipient'] as String,
  );
}

Map<String, dynamic> _$_$_SwapRequestBodyToJson(_$_SwapRequestBody instance) =>
    <String, dynamic>{
      'currencyIn': instance.currencyIn,
      'currencyOut': instance.currencyOut,
      'amountIn': instance.amountIn,
      'recipient': instance.recipient,
    };

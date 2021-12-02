// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TradeInfo _$$_TradeInfoFromJson(Map<String, dynamic> json) => _$_TradeInfo(
      inputAmount: json['inputAmount'] as String,
      outputAmount: json['outputAmount'] as String,
      route: (json['route'] as List<dynamic>).map((e) => e as String).toList(),
      inputToken: json['inputToken'] as String,
      outputToken: json['outputToken'] as String,
      executionPrice: json['executionPrice'] as String,
      nextMidPrice: json['nextMidPrice'] as String,
      priceImpact: json['priceImpact'] as String,
    );

Map<String, dynamic> _$$_TradeInfoToJson(_$_TradeInfo instance) =>
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

_$_SwapCallParameters _$$_SwapCallParametersFromJson(
        Map<String, dynamic> json) =>
    _$_SwapCallParameters(
      methodName: json['methodName'] as String,
      args: json['args'] as List<dynamic>,
      value: json['value'] as String,
      rawTxn: json['rawTxn'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_SwapCallParametersToJson(
        _$_SwapCallParameters instance) =>
    <String, dynamic>{
      'methodName': instance.methodName,
      'args': instance.args,
      'value': instance.value,
      'rawTxn': instance.rawTxn,
    };

_$_SwapRequestBody _$$_SwapRequestBodyFromJson(Map<String, dynamic> json) =>
    _$_SwapRequestBody(
      currencyIn: json['currencyIn'] as String? ?? '',
      currencyOut: json['currencyOut'] as String? ?? '',
      amountIn: json['amountIn'] as String? ?? '',
      recipient: json['recipient'] as String? ?? '',
    );

Map<String, dynamic> _$$_SwapRequestBodyToJson(_$_SwapRequestBody instance) =>
    <String, dynamic>{
      'currencyIn': instance.currencyIn,
      'currencyOut': instance.currencyOut,
      'amountIn': instance.amountIn,
      'recipient': instance.recipient,
    };

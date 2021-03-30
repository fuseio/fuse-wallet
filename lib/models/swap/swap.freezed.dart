// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TradeInfo _$TradeInfoFromJson(Map<String, dynamic> json) {
  return _TradeInfo.fromJson(json);
}

/// @nodoc
class _$TradeInfoTearOff {
  const _$TradeInfoTearOff();

// ignore: unused_element
  _TradeInfo call(
      {String inputAmount,
      String outputAmount,
      List<String> route,
      String inputToken,
      String outputToken,
      String executionPrice,
      String nextMidPrice,
      String priceImpact}) {
    return _TradeInfo(
      inputAmount: inputAmount,
      outputAmount: outputAmount,
      route: route,
      inputToken: inputToken,
      outputToken: outputToken,
      executionPrice: executionPrice,
      nextMidPrice: nextMidPrice,
      priceImpact: priceImpact,
    );
  }

// ignore: unused_element
  TradeInfo fromJson(Map<String, Object> json) {
    return TradeInfo.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $TradeInfo = _$TradeInfoTearOff();

/// @nodoc
mixin _$TradeInfo {
  String get inputAmount;
  String get outputAmount;
  List<String> get route;
  String get inputToken;
  String get outputToken;
  String get executionPrice;
  String get nextMidPrice;
  String get priceImpact;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TradeInfoCopyWith<TradeInfo> get copyWith;
}

/// @nodoc
abstract class $TradeInfoCopyWith<$Res> {
  factory $TradeInfoCopyWith(TradeInfo value, $Res Function(TradeInfo) then) =
      _$TradeInfoCopyWithImpl<$Res>;
  $Res call(
      {String inputAmount,
      String outputAmount,
      List<String> route,
      String inputToken,
      String outputToken,
      String executionPrice,
      String nextMidPrice,
      String priceImpact});
}

/// @nodoc
class _$TradeInfoCopyWithImpl<$Res> implements $TradeInfoCopyWith<$Res> {
  _$TradeInfoCopyWithImpl(this._value, this._then);

  final TradeInfo _value;
  // ignore: unused_field
  final $Res Function(TradeInfo) _then;

  @override
  $Res call({
    Object inputAmount = freezed,
    Object outputAmount = freezed,
    Object route = freezed,
    Object inputToken = freezed,
    Object outputToken = freezed,
    Object executionPrice = freezed,
    Object nextMidPrice = freezed,
    Object priceImpact = freezed,
  }) {
    return _then(_value.copyWith(
      inputAmount:
          inputAmount == freezed ? _value.inputAmount : inputAmount as String,
      outputAmount: outputAmount == freezed
          ? _value.outputAmount
          : outputAmount as String,
      route: route == freezed ? _value.route : route as List<String>,
      inputToken:
          inputToken == freezed ? _value.inputToken : inputToken as String,
      outputToken:
          outputToken == freezed ? _value.outputToken : outputToken as String,
      executionPrice: executionPrice == freezed
          ? _value.executionPrice
          : executionPrice as String,
      nextMidPrice: nextMidPrice == freezed
          ? _value.nextMidPrice
          : nextMidPrice as String,
      priceImpact:
          priceImpact == freezed ? _value.priceImpact : priceImpact as String,
    ));
  }
}

/// @nodoc
abstract class _$TradeInfoCopyWith<$Res> implements $TradeInfoCopyWith<$Res> {
  factory _$TradeInfoCopyWith(
          _TradeInfo value, $Res Function(_TradeInfo) then) =
      __$TradeInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String inputAmount,
      String outputAmount,
      List<String> route,
      String inputToken,
      String outputToken,
      String executionPrice,
      String nextMidPrice,
      String priceImpact});
}

/// @nodoc
class __$TradeInfoCopyWithImpl<$Res> extends _$TradeInfoCopyWithImpl<$Res>
    implements _$TradeInfoCopyWith<$Res> {
  __$TradeInfoCopyWithImpl(_TradeInfo _value, $Res Function(_TradeInfo) _then)
      : super(_value, (v) => _then(v as _TradeInfo));

  @override
  _TradeInfo get _value => super._value as _TradeInfo;

  @override
  $Res call({
    Object inputAmount = freezed,
    Object outputAmount = freezed,
    Object route = freezed,
    Object inputToken = freezed,
    Object outputToken = freezed,
    Object executionPrice = freezed,
    Object nextMidPrice = freezed,
    Object priceImpact = freezed,
  }) {
    return _then(_TradeInfo(
      inputAmount:
          inputAmount == freezed ? _value.inputAmount : inputAmount as String,
      outputAmount: outputAmount == freezed
          ? _value.outputAmount
          : outputAmount as String,
      route: route == freezed ? _value.route : route as List<String>,
      inputToken:
          inputToken == freezed ? _value.inputToken : inputToken as String,
      outputToken:
          outputToken == freezed ? _value.outputToken : outputToken as String,
      executionPrice: executionPrice == freezed
          ? _value.executionPrice
          : executionPrice as String,
      nextMidPrice: nextMidPrice == freezed
          ? _value.nextMidPrice
          : nextMidPrice as String,
      priceImpact:
          priceImpact == freezed ? _value.priceImpact : priceImpact as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_TradeInfo implements _TradeInfo {
  _$_TradeInfo(
      {this.inputAmount,
      this.outputAmount,
      this.route,
      this.inputToken,
      this.outputToken,
      this.executionPrice,
      this.nextMidPrice,
      this.priceImpact});

  factory _$_TradeInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_TradeInfoFromJson(json);

  @override
  final String inputAmount;
  @override
  final String outputAmount;
  @override
  final List<String> route;
  @override
  final String inputToken;
  @override
  final String outputToken;
  @override
  final String executionPrice;
  @override
  final String nextMidPrice;
  @override
  final String priceImpact;

  @override
  String toString() {
    return 'TradeInfo(inputAmount: $inputAmount, outputAmount: $outputAmount, route: $route, inputToken: $inputToken, outputToken: $outputToken, executionPrice: $executionPrice, nextMidPrice: $nextMidPrice, priceImpact: $priceImpact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TradeInfo &&
            (identical(other.inputAmount, inputAmount) ||
                const DeepCollectionEquality()
                    .equals(other.inputAmount, inputAmount)) &&
            (identical(other.outputAmount, outputAmount) ||
                const DeepCollectionEquality()
                    .equals(other.outputAmount, outputAmount)) &&
            (identical(other.route, route) ||
                const DeepCollectionEquality().equals(other.route, route)) &&
            (identical(other.inputToken, inputToken) ||
                const DeepCollectionEquality()
                    .equals(other.inputToken, inputToken)) &&
            (identical(other.outputToken, outputToken) ||
                const DeepCollectionEquality()
                    .equals(other.outputToken, outputToken)) &&
            (identical(other.executionPrice, executionPrice) ||
                const DeepCollectionEquality()
                    .equals(other.executionPrice, executionPrice)) &&
            (identical(other.nextMidPrice, nextMidPrice) ||
                const DeepCollectionEquality()
                    .equals(other.nextMidPrice, nextMidPrice)) &&
            (identical(other.priceImpact, priceImpact) ||
                const DeepCollectionEquality()
                    .equals(other.priceImpact, priceImpact)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(inputAmount) ^
      const DeepCollectionEquality().hash(outputAmount) ^
      const DeepCollectionEquality().hash(route) ^
      const DeepCollectionEquality().hash(inputToken) ^
      const DeepCollectionEquality().hash(outputToken) ^
      const DeepCollectionEquality().hash(executionPrice) ^
      const DeepCollectionEquality().hash(nextMidPrice) ^
      const DeepCollectionEquality().hash(priceImpact);

  @JsonKey(ignore: true)
  @override
  _$TradeInfoCopyWith<_TradeInfo> get copyWith =>
      __$TradeInfoCopyWithImpl<_TradeInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TradeInfoToJson(this);
  }
}

abstract class _TradeInfo implements TradeInfo {
  factory _TradeInfo(
      {String inputAmount,
      String outputAmount,
      List<String> route,
      String inputToken,
      String outputToken,
      String executionPrice,
      String nextMidPrice,
      String priceImpact}) = _$_TradeInfo;

  factory _TradeInfo.fromJson(Map<String, dynamic> json) =
      _$_TradeInfo.fromJson;

  @override
  String get inputAmount;
  @override
  String get outputAmount;
  @override
  List<String> get route;
  @override
  String get inputToken;
  @override
  String get outputToken;
  @override
  String get executionPrice;
  @override
  String get nextMidPrice;
  @override
  String get priceImpact;
  @override
  @JsonKey(ignore: true)
  _$TradeInfoCopyWith<_TradeInfo> get copyWith;
}

SwapCallParameters _$SwapCallParametersFromJson(Map<String, dynamic> json) {
  return _SwapCallParameters.fromJson(json);
}

/// @nodoc
class _$SwapCallParametersTearOff {
  const _$SwapCallParametersTearOff();

// ignore: unused_element
  _SwapCallParameters call(
      {String methodName,
      List<dynamic> args,
      String value,
      Map<String, dynamic> rawTxn}) {
    return _SwapCallParameters(
      methodName: methodName,
      args: args,
      value: value,
      rawTxn: rawTxn,
    );
  }

// ignore: unused_element
  SwapCallParameters fromJson(Map<String, Object> json) {
    return SwapCallParameters.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $SwapCallParameters = _$SwapCallParametersTearOff();

/// @nodoc
mixin _$SwapCallParameters {
  String get methodName;
  List<dynamic> get args;
  String get value;
  Map<String, dynamic> get rawTxn;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $SwapCallParametersCopyWith<SwapCallParameters> get copyWith;
}

/// @nodoc
abstract class $SwapCallParametersCopyWith<$Res> {
  factory $SwapCallParametersCopyWith(
          SwapCallParameters value, $Res Function(SwapCallParameters) then) =
      _$SwapCallParametersCopyWithImpl<$Res>;
  $Res call(
      {String methodName,
      List<dynamic> args,
      String value,
      Map<String, dynamic> rawTxn});
}

/// @nodoc
class _$SwapCallParametersCopyWithImpl<$Res>
    implements $SwapCallParametersCopyWith<$Res> {
  _$SwapCallParametersCopyWithImpl(this._value, this._then);

  final SwapCallParameters _value;
  // ignore: unused_field
  final $Res Function(SwapCallParameters) _then;

  @override
  $Res call({
    Object methodName = freezed,
    Object args = freezed,
    Object value = freezed,
    Object rawTxn = freezed,
  }) {
    return _then(_value.copyWith(
      methodName:
          methodName == freezed ? _value.methodName : methodName as String,
      args: args == freezed ? _value.args : args as List<dynamic>,
      value: value == freezed ? _value.value : value as String,
      rawTxn:
          rawTxn == freezed ? _value.rawTxn : rawTxn as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$SwapCallParametersCopyWith<$Res>
    implements $SwapCallParametersCopyWith<$Res> {
  factory _$SwapCallParametersCopyWith(
          _SwapCallParameters value, $Res Function(_SwapCallParameters) then) =
      __$SwapCallParametersCopyWithImpl<$Res>;
  @override
  $Res call(
      {String methodName,
      List<dynamic> args,
      String value,
      Map<String, dynamic> rawTxn});
}

/// @nodoc
class __$SwapCallParametersCopyWithImpl<$Res>
    extends _$SwapCallParametersCopyWithImpl<$Res>
    implements _$SwapCallParametersCopyWith<$Res> {
  __$SwapCallParametersCopyWithImpl(
      _SwapCallParameters _value, $Res Function(_SwapCallParameters) _then)
      : super(_value, (v) => _then(v as _SwapCallParameters));

  @override
  _SwapCallParameters get _value => super._value as _SwapCallParameters;

  @override
  $Res call({
    Object methodName = freezed,
    Object args = freezed,
    Object value = freezed,
    Object rawTxn = freezed,
  }) {
    return _then(_SwapCallParameters(
      methodName:
          methodName == freezed ? _value.methodName : methodName as String,
      args: args == freezed ? _value.args : args as List<dynamic>,
      value: value == freezed ? _value.value : value as String,
      rawTxn:
          rawTxn == freezed ? _value.rawTxn : rawTxn as Map<String, dynamic>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_SwapCallParameters implements _SwapCallParameters {
  _$_SwapCallParameters({this.methodName, this.args, this.value, this.rawTxn});

  factory _$_SwapCallParameters.fromJson(Map<String, dynamic> json) =>
      _$_$_SwapCallParametersFromJson(json);

  @override
  final String methodName;
  @override
  final List<dynamic> args;
  @override
  final String value;
  @override
  final Map<String, dynamic> rawTxn;

  @override
  String toString() {
    return 'SwapCallParameters(methodName: $methodName, args: $args, value: $value, rawTxn: $rawTxn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwapCallParameters &&
            (identical(other.methodName, methodName) ||
                const DeepCollectionEquality()
                    .equals(other.methodName, methodName)) &&
            (identical(other.args, args) ||
                const DeepCollectionEquality().equals(other.args, args)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.rawTxn, rawTxn) ||
                const DeepCollectionEquality().equals(other.rawTxn, rawTxn)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(methodName) ^
      const DeepCollectionEquality().hash(args) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(rawTxn);

  @JsonKey(ignore: true)
  @override
  _$SwapCallParametersCopyWith<_SwapCallParameters> get copyWith =>
      __$SwapCallParametersCopyWithImpl<_SwapCallParameters>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SwapCallParametersToJson(this);
  }
}

abstract class _SwapCallParameters implements SwapCallParameters {
  factory _SwapCallParameters(
      {String methodName,
      List<dynamic> args,
      String value,
      Map<String, dynamic> rawTxn}) = _$_SwapCallParameters;

  factory _SwapCallParameters.fromJson(Map<String, dynamic> json) =
      _$_SwapCallParameters.fromJson;

  @override
  String get methodName;
  @override
  List<dynamic> get args;
  @override
  String get value;
  @override
  Map<String, dynamic> get rawTxn;
  @override
  @JsonKey(ignore: true)
  _$SwapCallParametersCopyWith<_SwapCallParameters> get copyWith;
}

SwapRequestBody _$SwapRequestBodyFromJson(Map<String, dynamic> json) {
  return _SwapRequestBody.fromJson(json);
}

/// @nodoc
class _$SwapRequestBodyTearOff {
  const _$SwapRequestBodyTearOff();

// ignore: unused_element
  _SwapRequestBody call(
      {String currencyIn,
      String currencyOut,
      String amountIn,
      String recipient}) {
    return _SwapRequestBody(
      currencyIn: currencyIn,
      currencyOut: currencyOut,
      amountIn: amountIn,
      recipient: recipient,
    );
  }

// ignore: unused_element
  SwapRequestBody fromJson(Map<String, Object> json) {
    return SwapRequestBody.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $SwapRequestBody = _$SwapRequestBodyTearOff();

/// @nodoc
mixin _$SwapRequestBody {
  String get currencyIn;
  String get currencyOut;
  String get amountIn;
  String get recipient;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $SwapRequestBodyCopyWith<SwapRequestBody> get copyWith;
}

/// @nodoc
abstract class $SwapRequestBodyCopyWith<$Res> {
  factory $SwapRequestBodyCopyWith(
          SwapRequestBody value, $Res Function(SwapRequestBody) then) =
      _$SwapRequestBodyCopyWithImpl<$Res>;
  $Res call(
      {String currencyIn,
      String currencyOut,
      String amountIn,
      String recipient});
}

/// @nodoc
class _$SwapRequestBodyCopyWithImpl<$Res>
    implements $SwapRequestBodyCopyWith<$Res> {
  _$SwapRequestBodyCopyWithImpl(this._value, this._then);

  final SwapRequestBody _value;
  // ignore: unused_field
  final $Res Function(SwapRequestBody) _then;

  @override
  $Res call({
    Object currencyIn = freezed,
    Object currencyOut = freezed,
    Object amountIn = freezed,
    Object recipient = freezed,
  }) {
    return _then(_value.copyWith(
      currencyIn:
          currencyIn == freezed ? _value.currencyIn : currencyIn as String,
      currencyOut:
          currencyOut == freezed ? _value.currencyOut : currencyOut as String,
      amountIn: amountIn == freezed ? _value.amountIn : amountIn as String,
      recipient: recipient == freezed ? _value.recipient : recipient as String,
    ));
  }
}

/// @nodoc
abstract class _$SwapRequestBodyCopyWith<$Res>
    implements $SwapRequestBodyCopyWith<$Res> {
  factory _$SwapRequestBodyCopyWith(
          _SwapRequestBody value, $Res Function(_SwapRequestBody) then) =
      __$SwapRequestBodyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String currencyIn,
      String currencyOut,
      String amountIn,
      String recipient});
}

/// @nodoc
class __$SwapRequestBodyCopyWithImpl<$Res>
    extends _$SwapRequestBodyCopyWithImpl<$Res>
    implements _$SwapRequestBodyCopyWith<$Res> {
  __$SwapRequestBodyCopyWithImpl(
      _SwapRequestBody _value, $Res Function(_SwapRequestBody) _then)
      : super(_value, (v) => _then(v as _SwapRequestBody));

  @override
  _SwapRequestBody get _value => super._value as _SwapRequestBody;

  @override
  $Res call({
    Object currencyIn = freezed,
    Object currencyOut = freezed,
    Object amountIn = freezed,
    Object recipient = freezed,
  }) {
    return _then(_SwapRequestBody(
      currencyIn:
          currencyIn == freezed ? _value.currencyIn : currencyIn as String,
      currencyOut:
          currencyOut == freezed ? _value.currencyOut : currencyOut as String,
      amountIn: amountIn == freezed ? _value.amountIn : amountIn as String,
      recipient: recipient == freezed ? _value.recipient : recipient as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_SwapRequestBody implements _SwapRequestBody {
  _$_SwapRequestBody(
      {this.currencyIn, this.currencyOut, this.amountIn, this.recipient});

  factory _$_SwapRequestBody.fromJson(Map<String, dynamic> json) =>
      _$_$_SwapRequestBodyFromJson(json);

  @override
  final String currencyIn;
  @override
  final String currencyOut;
  @override
  final String amountIn;
  @override
  final String recipient;

  @override
  String toString() {
    return 'SwapRequestBody(currencyIn: $currencyIn, currencyOut: $currencyOut, amountIn: $amountIn, recipient: $recipient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwapRequestBody &&
            (identical(other.currencyIn, currencyIn) ||
                const DeepCollectionEquality()
                    .equals(other.currencyIn, currencyIn)) &&
            (identical(other.currencyOut, currencyOut) ||
                const DeepCollectionEquality()
                    .equals(other.currencyOut, currencyOut)) &&
            (identical(other.amountIn, amountIn) ||
                const DeepCollectionEquality()
                    .equals(other.amountIn, amountIn)) &&
            (identical(other.recipient, recipient) ||
                const DeepCollectionEquality()
                    .equals(other.recipient, recipient)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currencyIn) ^
      const DeepCollectionEquality().hash(currencyOut) ^
      const DeepCollectionEquality().hash(amountIn) ^
      const DeepCollectionEquality().hash(recipient);

  @JsonKey(ignore: true)
  @override
  _$SwapRequestBodyCopyWith<_SwapRequestBody> get copyWith =>
      __$SwapRequestBodyCopyWithImpl<_SwapRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SwapRequestBodyToJson(this);
  }
}

abstract class _SwapRequestBody implements SwapRequestBody {
  factory _SwapRequestBody(
      {String currencyIn,
      String currencyOut,
      String amountIn,
      String recipient}) = _$_SwapRequestBody;

  factory _SwapRequestBody.fromJson(Map<String, dynamic> json) =
      _$_SwapRequestBody.fromJson;

  @override
  String get currencyIn;
  @override
  String get currencyOut;
  @override
  String get amountIn;
  @override
  String get recipient;
  @override
  @JsonKey(ignore: true)
  _$SwapRequestBodyCopyWith<_SwapRequestBody> get copyWith;
}

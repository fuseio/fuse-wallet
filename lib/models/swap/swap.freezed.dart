// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TradeInfo _$TradeInfoFromJson(Map<String, dynamic> json) {
  return _TradeInfo.fromJson(json);
}

/// @nodoc
class _$TradeInfoTearOff {
  const _$TradeInfoTearOff();

  _TradeInfo call(
      {required String inputAmount,
      required String outputAmount,
      required List<String> route,
      required String inputToken,
      required String outputToken,
      required String executionPrice,
      required String nextMidPrice,
      required String priceImpact}) {
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

  TradeInfo fromJson(Map<String, Object?> json) {
    return TradeInfo.fromJson(json);
  }
}

/// @nodoc
const $TradeInfo = _$TradeInfoTearOff();

/// @nodoc
mixin _$TradeInfo {
  String get inputAmount => throw _privateConstructorUsedError;
  String get outputAmount => throw _privateConstructorUsedError;
  List<String> get route => throw _privateConstructorUsedError;
  String get inputToken => throw _privateConstructorUsedError;
  String get outputToken => throw _privateConstructorUsedError;
  String get executionPrice => throw _privateConstructorUsedError;
  String get nextMidPrice => throw _privateConstructorUsedError;
  String get priceImpact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeInfoCopyWith<TradeInfo> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? inputAmount = freezed,
    Object? outputAmount = freezed,
    Object? route = freezed,
    Object? inputToken = freezed,
    Object? outputToken = freezed,
    Object? executionPrice = freezed,
    Object? nextMidPrice = freezed,
    Object? priceImpact = freezed,
  }) {
    return _then(_value.copyWith(
      inputAmount: inputAmount == freezed
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outputAmount: outputAmount == freezed
          ? _value.outputAmount
          : outputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inputToken: inputToken == freezed
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: outputToken == freezed
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      executionPrice: executionPrice == freezed
          ? _value.executionPrice
          : executionPrice // ignore: cast_nullable_to_non_nullable
              as String,
      nextMidPrice: nextMidPrice == freezed
          ? _value.nextMidPrice
          : nextMidPrice // ignore: cast_nullable_to_non_nullable
              as String,
      priceImpact: priceImpact == freezed
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as String,
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
    Object? inputAmount = freezed,
    Object? outputAmount = freezed,
    Object? route = freezed,
    Object? inputToken = freezed,
    Object? outputToken = freezed,
    Object? executionPrice = freezed,
    Object? nextMidPrice = freezed,
    Object? priceImpact = freezed,
  }) {
    return _then(_TradeInfo(
      inputAmount: inputAmount == freezed
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outputAmount: outputAmount == freezed
          ? _value.outputAmount
          : outputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inputToken: inputToken == freezed
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: outputToken == freezed
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      executionPrice: executionPrice == freezed
          ? _value.executionPrice
          : executionPrice // ignore: cast_nullable_to_non_nullable
              as String,
      nextMidPrice: nextMidPrice == freezed
          ? _value.nextMidPrice
          : nextMidPrice // ignore: cast_nullable_to_non_nullable
              as String,
      priceImpact: priceImpact == freezed
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_TradeInfo implements _TradeInfo {
  _$_TradeInfo(
      {required this.inputAmount,
      required this.outputAmount,
      required this.route,
      required this.inputToken,
      required this.outputToken,
      required this.executionPrice,
      required this.nextMidPrice,
      required this.priceImpact});

  factory _$_TradeInfo.fromJson(Map<String, dynamic> json) =>
      _$$_TradeInfoFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _TradeInfo &&
            const DeepCollectionEquality()
                .equals(other.inputAmount, inputAmount) &&
            const DeepCollectionEquality()
                .equals(other.outputAmount, outputAmount) &&
            const DeepCollectionEquality().equals(other.route, route) &&
            const DeepCollectionEquality()
                .equals(other.inputToken, inputToken) &&
            const DeepCollectionEquality()
                .equals(other.outputToken, outputToken) &&
            const DeepCollectionEquality()
                .equals(other.executionPrice, executionPrice) &&
            const DeepCollectionEquality()
                .equals(other.nextMidPrice, nextMidPrice) &&
            const DeepCollectionEquality()
                .equals(other.priceImpact, priceImpact));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(inputAmount),
      const DeepCollectionEquality().hash(outputAmount),
      const DeepCollectionEquality().hash(route),
      const DeepCollectionEquality().hash(inputToken),
      const DeepCollectionEquality().hash(outputToken),
      const DeepCollectionEquality().hash(executionPrice),
      const DeepCollectionEquality().hash(nextMidPrice),
      const DeepCollectionEquality().hash(priceImpact));

  @JsonKey(ignore: true)
  @override
  _$TradeInfoCopyWith<_TradeInfo> get copyWith =>
      __$TradeInfoCopyWithImpl<_TradeInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TradeInfoToJson(this);
  }
}

abstract class _TradeInfo implements TradeInfo {
  factory _TradeInfo(
      {required String inputAmount,
      required String outputAmount,
      required List<String> route,
      required String inputToken,
      required String outputToken,
      required String executionPrice,
      required String nextMidPrice,
      required String priceImpact}) = _$_TradeInfo;

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
  _$TradeInfoCopyWith<_TradeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapCallParameters _$SwapCallParametersFromJson(Map<String, dynamic> json) {
  return _SwapCallParameters.fromJson(json);
}

/// @nodoc
class _$SwapCallParametersTearOff {
  const _$SwapCallParametersTearOff();

  _SwapCallParameters call(
      {required String methodName,
      required List<dynamic> args,
      required String value,
      required Map<String, dynamic> rawTxn}) {
    return _SwapCallParameters(
      methodName: methodName,
      args: args,
      value: value,
      rawTxn: rawTxn,
    );
  }

  SwapCallParameters fromJson(Map<String, Object?> json) {
    return SwapCallParameters.fromJson(json);
  }
}

/// @nodoc
const $SwapCallParameters = _$SwapCallParametersTearOff();

/// @nodoc
mixin _$SwapCallParameters {
  String get methodName => throw _privateConstructorUsedError;
  List<dynamic> get args => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  Map<String, dynamic> get rawTxn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapCallParametersCopyWith<SwapCallParameters> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? methodName = freezed,
    Object? args = freezed,
    Object? value = freezed,
    Object? rawTxn = freezed,
  }) {
    return _then(_value.copyWith(
      methodName: methodName == freezed
          ? _value.methodName
          : methodName // ignore: cast_nullable_to_non_nullable
              as String,
      args: args == freezed
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      rawTxn: rawTxn == freezed
          ? _value.rawTxn
          : rawTxn // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
    Object? methodName = freezed,
    Object? args = freezed,
    Object? value = freezed,
    Object? rawTxn = freezed,
  }) {
    return _then(_SwapCallParameters(
      methodName: methodName == freezed
          ? _value.methodName
          : methodName // ignore: cast_nullable_to_non_nullable
              as String,
      args: args == freezed
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      rawTxn: rawTxn == freezed
          ? _value.rawTxn
          : rawTxn // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SwapCallParameters implements _SwapCallParameters {
  _$_SwapCallParameters(
      {required this.methodName,
      required this.args,
      required this.value,
      required this.rawTxn});

  factory _$_SwapCallParameters.fromJson(Map<String, dynamic> json) =>
      _$$_SwapCallParametersFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _SwapCallParameters &&
            const DeepCollectionEquality()
                .equals(other.methodName, methodName) &&
            const DeepCollectionEquality().equals(other.args, args) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.rawTxn, rawTxn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(methodName),
      const DeepCollectionEquality().hash(args),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(rawTxn));

  @JsonKey(ignore: true)
  @override
  _$SwapCallParametersCopyWith<_SwapCallParameters> get copyWith =>
      __$SwapCallParametersCopyWithImpl<_SwapCallParameters>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapCallParametersToJson(this);
  }
}

abstract class _SwapCallParameters implements SwapCallParameters {
  factory _SwapCallParameters(
      {required String methodName,
      required List<dynamic> args,
      required String value,
      required Map<String, dynamic> rawTxn}) = _$_SwapCallParameters;

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
  _$SwapCallParametersCopyWith<_SwapCallParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapRequestBody _$SwapRequestBodyFromJson(Map<String, dynamic> json) {
  return _SwapRequestBody.fromJson(json);
}

/// @nodoc
class _$SwapRequestBodyTearOff {
  const _$SwapRequestBodyTearOff();

  _SwapRequestBody call(
      {String currencyIn = '',
      String currencyOut = '',
      String amountIn = '',
      String recipient = ''}) {
    return _SwapRequestBody(
      currencyIn: currencyIn,
      currencyOut: currencyOut,
      amountIn: amountIn,
      recipient: recipient,
    );
  }

  SwapRequestBody fromJson(Map<String, Object?> json) {
    return SwapRequestBody.fromJson(json);
  }
}

/// @nodoc
const $SwapRequestBody = _$SwapRequestBodyTearOff();

/// @nodoc
mixin _$SwapRequestBody {
  String get currencyIn => throw _privateConstructorUsedError;
  String get currencyOut => throw _privateConstructorUsedError;
  String get amountIn => throw _privateConstructorUsedError;
  String get recipient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRequestBodyCopyWith<SwapRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? currencyIn = freezed,
    Object? currencyOut = freezed,
    Object? amountIn = freezed,
    Object? recipient = freezed,
  }) {
    return _then(_value.copyWith(
      currencyIn: currencyIn == freezed
          ? _value.currencyIn
          : currencyIn // ignore: cast_nullable_to_non_nullable
              as String,
      currencyOut: currencyOut == freezed
          ? _value.currencyOut
          : currencyOut // ignore: cast_nullable_to_non_nullable
              as String,
      amountIn: amountIn == freezed
          ? _value.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
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
    Object? currencyIn = freezed,
    Object? currencyOut = freezed,
    Object? amountIn = freezed,
    Object? recipient = freezed,
  }) {
    return _then(_SwapRequestBody(
      currencyIn: currencyIn == freezed
          ? _value.currencyIn
          : currencyIn // ignore: cast_nullable_to_non_nullable
              as String,
      currencyOut: currencyOut == freezed
          ? _value.currencyOut
          : currencyOut // ignore: cast_nullable_to_non_nullable
              as String,
      amountIn: amountIn == freezed
          ? _value.amountIn
          : amountIn // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SwapRequestBody implements _SwapRequestBody {
  _$_SwapRequestBody(
      {this.currencyIn = '',
      this.currencyOut = '',
      this.amountIn = '',
      this.recipient = ''});

  factory _$_SwapRequestBody.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRequestBodyFromJson(json);

  @JsonKey()
  @override
  final String currencyIn;
  @JsonKey()
  @override
  final String currencyOut;
  @JsonKey()
  @override
  final String amountIn;
  @JsonKey()
  @override
  final String recipient;

  @override
  String toString() {
    return 'SwapRequestBody(currencyIn: $currencyIn, currencyOut: $currencyOut, amountIn: $amountIn, recipient: $recipient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SwapRequestBody &&
            const DeepCollectionEquality()
                .equals(other.currencyIn, currencyIn) &&
            const DeepCollectionEquality()
                .equals(other.currencyOut, currencyOut) &&
            const DeepCollectionEquality().equals(other.amountIn, amountIn) &&
            const DeepCollectionEquality().equals(other.recipient, recipient));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currencyIn),
      const DeepCollectionEquality().hash(currencyOut),
      const DeepCollectionEquality().hash(amountIn),
      const DeepCollectionEquality().hash(recipient));

  @JsonKey(ignore: true)
  @override
  _$SwapRequestBodyCopyWith<_SwapRequestBody> get copyWith =>
      __$SwapRequestBodyCopyWithImpl<_SwapRequestBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRequestBodyToJson(this);
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
  _$SwapRequestBodyCopyWith<_SwapRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

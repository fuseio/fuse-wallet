// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'swap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
SwapState _$SwapStateFromJson(Map<String, dynamic> json) {
  return _SwapState.fromJson(json);
}

/// @nodoc
class _$SwapStateTearOff {
  const _$SwapStateTearOff();

// ignore: unused_element
  _SwapState call({@JsonKey(ignore: true) List<Token> tokensList = const []}) {
    return _SwapState(
      tokensList: tokensList,
    );
  }

// ignore: unused_element
  SwapState fromJson(Map<String, Object> json) {
    return SwapState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $SwapState = _$SwapStateTearOff();

/// @nodoc
mixin _$SwapState {
  @JsonKey(ignore: true)
  List<Token> get tokensList;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $SwapStateCopyWith<SwapState> get copyWith;
}

/// @nodoc
abstract class $SwapStateCopyWith<$Res> {
  factory $SwapStateCopyWith(SwapState value, $Res Function(SwapState) then) =
      _$SwapStateCopyWithImpl<$Res>;
  $Res call({@JsonKey(ignore: true) List<Token> tokensList});
}

/// @nodoc
class _$SwapStateCopyWithImpl<$Res> implements $SwapStateCopyWith<$Res> {
  _$SwapStateCopyWithImpl(this._value, this._then);

  final SwapState _value;
  // ignore: unused_field
  final $Res Function(SwapState) _then;

  @override
  $Res call({
    Object tokensList = freezed,
  }) {
    return _then(_value.copyWith(
      tokensList:
          tokensList == freezed ? _value.tokensList : tokensList as List<Token>,
    ));
  }
}

/// @nodoc
abstract class _$SwapStateCopyWith<$Res> implements $SwapStateCopyWith<$Res> {
  factory _$SwapStateCopyWith(
          _SwapState value, $Res Function(_SwapState) then) =
      __$SwapStateCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(ignore: true) List<Token> tokensList});
}

/// @nodoc
class __$SwapStateCopyWithImpl<$Res> extends _$SwapStateCopyWithImpl<$Res>
    implements _$SwapStateCopyWith<$Res> {
  __$SwapStateCopyWithImpl(_SwapState _value, $Res Function(_SwapState) _then)
      : super(_value, (v) => _then(v as _SwapState));

  @override
  _SwapState get _value => super._value as _SwapState;

  @override
  $Res call({
    Object tokensList = freezed,
  }) {
    return _then(_SwapState(
      tokensList:
          tokensList == freezed ? _value.tokensList : tokensList as List<Token>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_SwapState extends _SwapState {
  _$_SwapState({@JsonKey(ignore: true) this.tokensList = const []})
      : assert(tokensList != null),
        super._();

  factory _$_SwapState.fromJson(Map<String, dynamic> json) =>
      _$_$_SwapStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final List<Token> tokensList;

  @override
  String toString() {
    return 'SwapState(tokensList: $tokensList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwapState &&
            (identical(other.tokensList, tokensList) ||
                const DeepCollectionEquality()
                    .equals(other.tokensList, tokensList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tokensList);

  @JsonKey(ignore: true)
  @override
  _$SwapStateCopyWith<_SwapState> get copyWith =>
      __$SwapStateCopyWithImpl<_SwapState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SwapStateToJson(this);
  }
}

abstract class _SwapState extends SwapState {
  _SwapState._() : super._();
  factory _SwapState({@JsonKey(ignore: true) List<Token> tokensList}) =
      _$_SwapState;

  factory _SwapState.fromJson(Map<String, dynamic> json) =
      _$_SwapState.fromJson;

  @override
  @JsonKey(ignore: true)
  List<Token> get tokensList;
  @override
  @JsonKey(ignore: true)
  _$SwapStateCopyWith<_SwapState> get copyWith;
}

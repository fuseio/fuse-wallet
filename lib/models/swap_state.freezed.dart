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
  _SwapState call(
      {@JsonKey(ignore: true) Map<String, Token> tokens = const {},
      Map<String, String> tokensImages = const {}}) {
    return _SwapState(
      tokens: tokens,
      tokensImages: tokensImages,
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
  Map<String, Token> get tokens;
  Map<String, String> get tokensImages;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $SwapStateCopyWith<SwapState> get copyWith;
}

/// @nodoc
abstract class $SwapStateCopyWith<$Res> {
  factory $SwapStateCopyWith(SwapState value, $Res Function(SwapState) then) =
      _$SwapStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) Map<String, Token> tokens,
      Map<String, String> tokensImages});
}

/// @nodoc
class _$SwapStateCopyWithImpl<$Res> implements $SwapStateCopyWith<$Res> {
  _$SwapStateCopyWithImpl(this._value, this._then);

  final SwapState _value;
  // ignore: unused_field
  final $Res Function(SwapState) _then;

  @override
  $Res call({
    Object tokens = freezed,
    Object tokensImages = freezed,
  }) {
    return _then(_value.copyWith(
      tokens: tokens == freezed ? _value.tokens : tokens as Map<String, Token>,
      tokensImages: tokensImages == freezed
          ? _value.tokensImages
          : tokensImages as Map<String, String>,
    ));
  }
}

/// @nodoc
abstract class _$SwapStateCopyWith<$Res> implements $SwapStateCopyWith<$Res> {
  factory _$SwapStateCopyWith(
          _SwapState value, $Res Function(_SwapState) then) =
      __$SwapStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) Map<String, Token> tokens,
      Map<String, String> tokensImages});
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
    Object tokens = freezed,
    Object tokensImages = freezed,
  }) {
    return _then(_SwapState(
      tokens: tokens == freezed ? _value.tokens : tokens as Map<String, Token>,
      tokensImages: tokensImages == freezed
          ? _value.tokensImages
          : tokensImages as Map<String, String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_SwapState extends _SwapState {
  _$_SwapState(
      {@JsonKey(ignore: true) this.tokens = const {},
      this.tokensImages = const {}})
      : assert(tokens != null),
        assert(tokensImages != null),
        super._();

  factory _$_SwapState.fromJson(Map<String, dynamic> json) =>
      _$_$_SwapStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final Map<String, Token> tokens;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, String> tokensImages;

  @override
  String toString() {
    return 'SwapState(tokens: $tokens, tokensImages: $tokensImages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwapState &&
            (identical(other.tokens, tokens) ||
                const DeepCollectionEquality().equals(other.tokens, tokens)) &&
            (identical(other.tokensImages, tokensImages) ||
                const DeepCollectionEquality()
                    .equals(other.tokensImages, tokensImages)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tokens) ^
      const DeepCollectionEquality().hash(tokensImages);

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
  factory _SwapState(
      {@JsonKey(ignore: true) Map<String, Token> tokens,
      Map<String, String> tokensImages}) = _$_SwapState;

  factory _SwapState.fromJson(Map<String, dynamic> json) =
      _$_SwapState.fromJson;

  @override
  @JsonKey(ignore: true)
  Map<String, Token> get tokens;
  @override
  Map<String, String> get tokensImages;
  @override
  @JsonKey(ignore: true)
  _$SwapStateCopyWith<_SwapState> get copyWith;
}

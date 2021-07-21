// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'swap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwapState _$SwapStateFromJson(Map<String, dynamic> json) {
  return _SwapState.fromJson(json);
}

/// @nodoc
class _$SwapStateTearOff {
  const _$SwapStateTearOff();

  _SwapState call(
      {@JsonKey(ignore: true) Map<String, Token> tokens = const {},
      Map<String, String> tokensImages = const {}}) {
    return _SwapState(
      tokens: tokens,
      tokensImages: tokensImages,
    );
  }

  SwapState fromJson(Map<String, Object> json) {
    return SwapState.fromJson(json);
  }
}

/// @nodoc
const $SwapState = _$SwapStateTearOff();

/// @nodoc
mixin _$SwapState {
  @JsonKey(ignore: true)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  Map<String, String> get tokensImages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapStateCopyWith<SwapState> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? tokens = freezed,
    Object? tokensImages = freezed,
  }) {
    return _then(_value.copyWith(
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      tokensImages: tokensImages == freezed
          ? _value.tokensImages
          : tokensImages // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
    Object? tokens = freezed,
    Object? tokensImages = freezed,
  }) {
    return _then(_SwapState(
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      tokensImages: tokensImages == freezed
          ? _value.tokensImages
          : tokensImages // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SwapState extends _SwapState with DiagnosticableTreeMixin {
  _$_SwapState(
      {@JsonKey(ignore: true) this.tokens = const {},
      this.tokensImages = const {}})
      : super._();

  factory _$_SwapState.fromJson(Map<String, dynamic> json) =>
      _$_$_SwapStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final Map<String, Token> tokens;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, String> tokensImages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SwapState(tokens: $tokens, tokensImages: $tokensImages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SwapState'))
      ..add(DiagnosticsProperty('tokens', tokens))
      ..add(DiagnosticsProperty('tokensImages', tokensImages));
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
  factory _SwapState(
      {@JsonKey(ignore: true) Map<String, Token> tokens,
      Map<String, String> tokensImages}) = _$_SwapState;
  _SwapState._() : super._();

  factory _SwapState.fromJson(Map<String, dynamic> json) =
      _$_SwapState.fromJson;

  @override
  @JsonKey(ignore: true)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  @override
  Map<String, String> get tokensImages => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SwapStateCopyWith<_SwapState> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'swap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwapState _$SwapStateFromJson(Map<String, dynamic> json) {
  return _SwapState.fromJson(json);
}

/// @nodoc
mixin _$SwapState {
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  Map<String, String> get tokensImages => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFetching => throw _privateConstructorUsedError;

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
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      Map<String, String> tokensImages,
      @JsonKey(ignore: true) bool isFetching});
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
    Object? isFetching = freezed,
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
      isFetching: isFetching == freezed
          ? _value.isFetching
          : isFetching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_SwapStateCopyWith<$Res> implements $SwapStateCopyWith<$Res> {
  factory _$$_SwapStateCopyWith(
          _$_SwapState value, $Res Function(_$_SwapState) then) =
      __$$_SwapStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      Map<String, String> tokensImages,
      @JsonKey(ignore: true) bool isFetching});
}

/// @nodoc
class __$$_SwapStateCopyWithImpl<$Res> extends _$SwapStateCopyWithImpl<$Res>
    implements _$$_SwapStateCopyWith<$Res> {
  __$$_SwapStateCopyWithImpl(
      _$_SwapState _value, $Res Function(_$_SwapState) _then)
      : super(_value, (v) => _then(v as _$_SwapState));

  @override
  _$_SwapState get _value => super._value as _$_SwapState;

  @override
  $Res call({
    Object? tokens = freezed,
    Object? tokensImages = freezed,
    Object? isFetching = freezed,
  }) {
    return _then(_$_SwapState(
      tokens: tokens == freezed
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      tokensImages: tokensImages == freezed
          ? _value.tokensImages
          : tokensImages // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isFetching: isFetching == freezed
          ? _value.isFetching
          : isFetching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapState extends _SwapState {
  _$_SwapState(
      {@JsonKey(fromJson: tokensFromJson) this.tokens = const {},
      this.tokensImages = const {},
      @JsonKey(ignore: true) this.isFetching = false})
      : super._();

  factory _$_SwapState.fromJson(Map<String, dynamic> json) =>
      _$$_SwapStateFromJson(json);

  @override
  @JsonKey(fromJson: tokensFromJson)
  final Map<String, Token> tokens;
  @override
  @JsonKey()
  final Map<String, String> tokensImages;
  @override
  @JsonKey(ignore: true)
  final bool isFetching;

  @override
  String toString() {
    return 'SwapState(tokens: $tokens, tokensImages: $tokensImages, isFetching: $isFetching)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapState &&
            const DeepCollectionEquality().equals(other.tokens, tokens) &&
            const DeepCollectionEquality()
                .equals(other.tokensImages, tokensImages) &&
            const DeepCollectionEquality()
                .equals(other.isFetching, isFetching));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tokens),
      const DeepCollectionEquality().hash(tokensImages),
      const DeepCollectionEquality().hash(isFetching));

  @JsonKey(ignore: true)
  @override
  _$$_SwapStateCopyWith<_$_SwapState> get copyWith =>
      __$$_SwapStateCopyWithImpl<_$_SwapState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapStateToJson(
      this,
    );
  }
}

abstract class _SwapState extends SwapState {
  factory _SwapState(
      {@JsonKey(fromJson: tokensFromJson) final Map<String, Token> tokens,
      final Map<String, String> tokensImages,
      @JsonKey(ignore: true) final bool isFetching}) = _$_SwapState;
  _SwapState._() : super._();

  factory _SwapState.fromJson(Map<String, dynamic> json) =
      _$_SwapState.fromJson;

  @override
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens;
  @override
  Map<String, String> get tokensImages;
  @override
  @JsonKey(ignore: true)
  bool get isFetching;
  @override
  @JsonKey(ignore: true)
  _$$_SwapStateCopyWith<_$_SwapState> get copyWith =>
      throw _privateConstructorUsedError;
}

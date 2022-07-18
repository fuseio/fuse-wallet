// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NftsState _$NftsStateFromJson(Map<String, dynamic> json) {
  return _NftsState.fromJson(json);
}

/// @nodoc
mixin _$NftsState {
  Map<String, Map<int, Collectible>> get collectibles =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NftsStateCopyWith<NftsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftsStateCopyWith<$Res> {
  factory $NftsStateCopyWith(NftsState value, $Res Function(NftsState) then) =
      _$NftsStateCopyWithImpl<$Res>;
  $Res call({Map<String, Map<int, Collectible>> collectibles});
}

/// @nodoc
class _$NftsStateCopyWithImpl<$Res> implements $NftsStateCopyWith<$Res> {
  _$NftsStateCopyWithImpl(this._value, this._then);

  final NftsState _value;
  // ignore: unused_field
  final $Res Function(NftsState) _then;

  @override
  $Res call({
    Object? collectibles = freezed,
  }) {
    return _then(_value.copyWith(
      collectibles: collectibles == freezed
          ? _value.collectibles
          : collectibles // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<int, Collectible>>,
    ));
  }
}

/// @nodoc
abstract class _$$_NftsStateCopyWith<$Res> implements $NftsStateCopyWith<$Res> {
  factory _$$_NftsStateCopyWith(
          _$_NftsState value, $Res Function(_$_NftsState) then) =
      __$$_NftsStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, Map<int, Collectible>> collectibles});
}

/// @nodoc
class __$$_NftsStateCopyWithImpl<$Res> extends _$NftsStateCopyWithImpl<$Res>
    implements _$$_NftsStateCopyWith<$Res> {
  __$$_NftsStateCopyWithImpl(
      _$_NftsState _value, $Res Function(_$_NftsState) _then)
      : super(_value, (v) => _then(v as _$_NftsState));

  @override
  _$_NftsState get _value => super._value as _$_NftsState;

  @override
  $Res call({
    Object? collectibles = freezed,
  }) {
    return _then(_$_NftsState(
      collectibles: collectibles == freezed
          ? _value.collectibles
          : collectibles // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<int, Collectible>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NftsState with DiagnosticableTreeMixin implements _NftsState {
  _$_NftsState({this.collectibles = const {}});

  factory _$_NftsState.fromJson(Map<String, dynamic> json) =>
      _$$_NftsStateFromJson(json);

  @override
  @JsonKey()
  final Map<String, Map<int, Collectible>> collectibles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NftsState(collectibles: $collectibles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NftsState'))
      ..add(DiagnosticsProperty('collectibles', collectibles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NftsState &&
            const DeepCollectionEquality()
                .equals(other.collectibles, collectibles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(collectibles));

  @JsonKey(ignore: true)
  @override
  _$$_NftsStateCopyWith<_$_NftsState> get copyWith =>
      __$$_NftsStateCopyWithImpl<_$_NftsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NftsStateToJson(
      this,
    );
  }
}

abstract class _NftsState implements NftsState {
  factory _NftsState({final Map<String, Map<int, Collectible>> collectibles}) =
      _$_NftsState;

  factory _NftsState.fromJson(Map<String, dynamic> json) =
      _$_NftsState.fromJson;

  @override
  Map<String, Map<int, Collectible>> get collectibles;
  @override
  @JsonKey(ignore: true)
  _$$_NftsStateCopyWith<_$_NftsState> get copyWith =>
      throw _privateConstructorUsedError;
}

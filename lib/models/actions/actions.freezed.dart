// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletActions _$WalletActionsFromJson(Map<String, dynamic> json) {
  return _WalletActions.fromJson(json);
}

/// @nodoc
class _$WalletActionsTearOff {
  const _$WalletActionsTearOff();

  _WalletActions call(
      {List<WalletAction> list = const <WalletAction>[], num updatedAt = 0}) {
    return _WalletActions(
      list: list,
      updatedAt: updatedAt,
    );
  }

  WalletActions fromJson(Map<String, Object> json) {
    return WalletActions.fromJson(json);
  }
}

/// @nodoc
const $WalletActions = _$WalletActionsTearOff();

/// @nodoc
mixin _$WalletActions {
  List<WalletAction> get list => throw _privateConstructorUsedError;
  num get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletActionsCopyWith<WalletActions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletActionsCopyWith<$Res> {
  factory $WalletActionsCopyWith(
          WalletActions value, $Res Function(WalletActions) then) =
      _$WalletActionsCopyWithImpl<$Res>;
  $Res call({List<WalletAction> list, num updatedAt});
}

/// @nodoc
class _$WalletActionsCopyWithImpl<$Res>
    implements $WalletActionsCopyWith<$Res> {
  _$WalletActionsCopyWithImpl(this._value, this._then);

  final WalletActions _value;
  // ignore: unused_field
  final $Res Function(WalletActions) _then;

  @override
  $Res call({
    Object? list = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<WalletAction>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$WalletActionsCopyWith<$Res>
    implements $WalletActionsCopyWith<$Res> {
  factory _$WalletActionsCopyWith(
          _WalletActions value, $Res Function(_WalletActions) then) =
      __$WalletActionsCopyWithImpl<$Res>;
  @override
  $Res call({List<WalletAction> list, num updatedAt});
}

/// @nodoc
class __$WalletActionsCopyWithImpl<$Res>
    extends _$WalletActionsCopyWithImpl<$Res>
    implements _$WalletActionsCopyWith<$Res> {
  __$WalletActionsCopyWithImpl(
      _WalletActions _value, $Res Function(_WalletActions) _then)
      : super(_value, (v) => _then(v as _WalletActions));

  @override
  _WalletActions get _value => super._value as _WalletActions;

  @override
  $Res call({
    Object? list = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_WalletActions(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<WalletAction>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WalletActions extends _WalletActions with DiagnosticableTreeMixin {
  _$_WalletActions({this.list = const <WalletAction>[], this.updatedAt = 0})
      : super._();

  factory _$_WalletActions.fromJson(Map<String, dynamic> json) =>
      _$_$_WalletActionsFromJson(json);

  @JsonKey(defaultValue: const <WalletAction>[])
  @override
  final List<WalletAction> list;
  @JsonKey(defaultValue: 0)
  @override
  final num updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletActions(list: $list, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletActions'))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletActions &&
            (identical(other.list, list) ||
                const DeepCollectionEquality().equals(other.list, list)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(list) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$WalletActionsCopyWith<_WalletActions> get copyWith =>
      __$WalletActionsCopyWithImpl<_WalletActions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WalletActionsToJson(this);
  }
}

abstract class _WalletActions extends WalletActions {
  factory _WalletActions({List<WalletAction> list, num updatedAt}) =
      _$_WalletActions;
  _WalletActions._() : super._();

  factory _WalletActions.fromJson(Map<String, dynamic> json) =
      _$_WalletActions.fromJson;

  @override
  List<WalletAction> get list => throw _privateConstructorUsedError;
  @override
  num get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WalletActionsCopyWith<_WalletActions> get copyWith =>
      throw _privateConstructorUsedError;
}

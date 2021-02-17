// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
WalletActions _$WalletActionsFromJson(Map<String, dynamic> json) {
  return _WalletActions.fromJson(json);
}

/// @nodoc
class _$WalletActionsTearOff {
  const _$WalletActionsTearOff();

// ignore: unused_element
  _WalletActions call(
      {@JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
          List<WalletAction> list,
      num updatedAt = 0}) {
    return _WalletActions(
      list: list,
      updatedAt: updatedAt,
    );
  }

// ignore: unused_element
  WalletActions fromJson(Map<String, Object> json) {
    return WalletActions.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $WalletActions = _$WalletActionsTearOff();

/// @nodoc
mixin _$WalletActions {
  @JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
  List<WalletAction> get list;
  num get updatedAt;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $WalletActionsCopyWith<WalletActions> get copyWith;
}

/// @nodoc
abstract class $WalletActionsCopyWith<$Res> {
  factory $WalletActionsCopyWith(
          WalletActions value, $Res Function(WalletActions) then) =
      _$WalletActionsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
          List<WalletAction> list,
      num updatedAt});
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
    Object list = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      list: list == freezed ? _value.list : list as List<WalletAction>,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as num,
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
  $Res call(
      {@JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
          List<WalletAction> list,
      num updatedAt});
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
    Object list = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_WalletActions(
      list: list == freezed ? _value.list : list as List<WalletAction>,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as num,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_WalletActions implements _WalletActions {
  _$_WalletActions(
      {@JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
          this.list,
      this.updatedAt = 0})
      : assert(updatedAt != null);

  factory _$_WalletActions.fromJson(Map<String, dynamic> json) =>
      _$_$_WalletActionsFromJson(json);

  @override
  @JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
  final List<WalletAction> list;
  @JsonKey(defaultValue: 0)
  @override
  final num updatedAt;

  @override
  String toString() {
    return 'WalletActions(list: $list, updatedAt: $updatedAt)';
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

abstract class _WalletActions implements WalletActions {
  factory _WalletActions(
      {@JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
          List<WalletAction> list,
      num updatedAt}) = _$_WalletActions;

  factory _WalletActions.fromJson(Map<String, dynamic> json) =
      _$_WalletActions.fromJson;

  @override
  @JsonKey(name: 'list', fromJson: listFromJson, toJson: listToJson)
  List<WalletAction> get list;
  @override
  num get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$WalletActionsCopyWith<_WalletActions> get copyWith;
}

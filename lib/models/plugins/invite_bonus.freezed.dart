// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'invite_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
InviteBonusPlugin _$InviteBonusPluginFromJson(Map<String, dynamic> json) {
  return _InviteBonusPlugin.fromJson(json);
}

/// @nodoc
class _$InviteBonusPluginTearOff {
  const _$InviteBonusPluginTearOff();

// ignore: unused_element
  _InviteBonusPlugin call(
      {String type = 'inviteBonus',
      String amount,
      String name,
      bool isActive}) {
    return _InviteBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

// ignore: unused_element
  InviteBonusPlugin fromJson(Map<String, Object> json) {
    return InviteBonusPlugin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $InviteBonusPlugin = _$InviteBonusPluginTearOff();

/// @nodoc
mixin _$InviteBonusPlugin {
  String get type;
  String get amount;
  String get name;
  bool get isActive;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $InviteBonusPluginCopyWith<InviteBonusPlugin> get copyWith;
}

/// @nodoc
abstract class $InviteBonusPluginCopyWith<$Res> {
  factory $InviteBonusPluginCopyWith(
          InviteBonusPlugin value, $Res Function(InviteBonusPlugin) then) =
      _$InviteBonusPluginCopyWithImpl<$Res>;
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class _$InviteBonusPluginCopyWithImpl<$Res>
    implements $InviteBonusPluginCopyWith<$Res> {
  _$InviteBonusPluginCopyWithImpl(this._value, this._then);

  final InviteBonusPlugin _value;
  // ignore: unused_field
  final $Res Function(InviteBonusPlugin) _then;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
    Object name = freezed,
    Object isActive = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as String,
      amount: amount == freezed ? _value.amount : amount as String,
      name: name == freezed ? _value.name : name as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }
}

/// @nodoc
abstract class _$InviteBonusPluginCopyWith<$Res>
    implements $InviteBonusPluginCopyWith<$Res> {
  factory _$InviteBonusPluginCopyWith(
          _InviteBonusPlugin value, $Res Function(_InviteBonusPlugin) then) =
      __$InviteBonusPluginCopyWithImpl<$Res>;
  @override
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class __$InviteBonusPluginCopyWithImpl<$Res>
    extends _$InviteBonusPluginCopyWithImpl<$Res>
    implements _$InviteBonusPluginCopyWith<$Res> {
  __$InviteBonusPluginCopyWithImpl(
      _InviteBonusPlugin _value, $Res Function(_InviteBonusPlugin) _then)
      : super(_value, (v) => _then(v as _InviteBonusPlugin));

  @override
  _InviteBonusPlugin get _value => super._value as _InviteBonusPlugin;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
    Object name = freezed,
    Object isActive = freezed,
  }) {
    return _then(_InviteBonusPlugin(
      type: type == freezed ? _value.type : type as String,
      amount: amount == freezed ? _value.amount : amount as String,
      name: name == freezed ? _value.name : name as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }
}

@Implements(Plugin)
@JsonSerializable()

/// @nodoc
class _$_InviteBonusPlugin implements _InviteBonusPlugin {
  _$_InviteBonusPlugin(
      {this.type = 'inviteBonus', this.amount, this.name, this.isActive})
      : assert(type != null);

  factory _$_InviteBonusPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_InviteBonusPluginFromJson(json);

  @JsonKey(defaultValue: 'inviteBonus')
  @override
  final String type;
  @override
  final String amount;
  @override
  final String name;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'InviteBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InviteBonusPlugin &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(isActive);

  @JsonKey(ignore: true)
  @override
  _$InviteBonusPluginCopyWith<_InviteBonusPlugin> get copyWith =>
      __$InviteBonusPluginCopyWithImpl<_InviteBonusPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InviteBonusPluginToJson(this);
  }
}

abstract class _InviteBonusPlugin implements InviteBonusPlugin, Plugin {
  factory _InviteBonusPlugin(
      {String type,
      String amount,
      String name,
      bool isActive}) = _$_InviteBonusPlugin;

  factory _InviteBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_InviteBonusPlugin.fromJson;

  @override
  String get type;
  @override
  String get amount;
  @override
  String get name;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$InviteBonusPluginCopyWith<_InviteBonusPlugin> get copyWith;
}

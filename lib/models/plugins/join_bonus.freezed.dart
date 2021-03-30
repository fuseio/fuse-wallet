// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'join_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
JoinBonusPlugin _$JoinBonusPluginFromJson(Map<String, dynamic> json) {
  return _JoinBonusPlugin.fromJson(json);
}

/// @nodoc
class _$JoinBonusPluginTearOff {
  const _$JoinBonusPluginTearOff();

// ignore: unused_element
  _JoinBonusPlugin call(
      {String type = 'joinBonus', String amount, String name, bool isActive}) {
    return _JoinBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

// ignore: unused_element
  JoinBonusPlugin fromJson(Map<String, Object> json) {
    return JoinBonusPlugin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $JoinBonusPlugin = _$JoinBonusPluginTearOff();

/// @nodoc
mixin _$JoinBonusPlugin {
  String get type;
  String get amount;
  String get name;
  bool get isActive;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $JoinBonusPluginCopyWith<JoinBonusPlugin> get copyWith;
}

/// @nodoc
abstract class $JoinBonusPluginCopyWith<$Res> {
  factory $JoinBonusPluginCopyWith(
          JoinBonusPlugin value, $Res Function(JoinBonusPlugin) then) =
      _$JoinBonusPluginCopyWithImpl<$Res>;
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class _$JoinBonusPluginCopyWithImpl<$Res>
    implements $JoinBonusPluginCopyWith<$Res> {
  _$JoinBonusPluginCopyWithImpl(this._value, this._then);

  final JoinBonusPlugin _value;
  // ignore: unused_field
  final $Res Function(JoinBonusPlugin) _then;

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
abstract class _$JoinBonusPluginCopyWith<$Res>
    implements $JoinBonusPluginCopyWith<$Res> {
  factory _$JoinBonusPluginCopyWith(
          _JoinBonusPlugin value, $Res Function(_JoinBonusPlugin) then) =
      __$JoinBonusPluginCopyWithImpl<$Res>;
  @override
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class __$JoinBonusPluginCopyWithImpl<$Res>
    extends _$JoinBonusPluginCopyWithImpl<$Res>
    implements _$JoinBonusPluginCopyWith<$Res> {
  __$JoinBonusPluginCopyWithImpl(
      _JoinBonusPlugin _value, $Res Function(_JoinBonusPlugin) _then)
      : super(_value, (v) => _then(v as _JoinBonusPlugin));

  @override
  _JoinBonusPlugin get _value => super._value as _JoinBonusPlugin;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
    Object name = freezed,
    Object isActive = freezed,
  }) {
    return _then(_JoinBonusPlugin(
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
class _$_JoinBonusPlugin implements _JoinBonusPlugin {
  _$_JoinBonusPlugin(
      {this.type = 'joinBonus', this.amount, this.name, this.isActive})
      : assert(type != null);

  factory _$_JoinBonusPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_JoinBonusPluginFromJson(json);

  @JsonKey(defaultValue: 'joinBonus')
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
    return 'JoinBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _JoinBonusPlugin &&
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
  _$JoinBonusPluginCopyWith<_JoinBonusPlugin> get copyWith =>
      __$JoinBonusPluginCopyWithImpl<_JoinBonusPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_JoinBonusPluginToJson(this);
  }
}

abstract class _JoinBonusPlugin implements JoinBonusPlugin, Plugin {
  factory _JoinBonusPlugin(
      {String type,
      String amount,
      String name,
      bool isActive}) = _$_JoinBonusPlugin;

  factory _JoinBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_JoinBonusPlugin.fromJson;

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
  _$JoinBonusPluginCopyWith<_JoinBonusPlugin> get copyWith;
}

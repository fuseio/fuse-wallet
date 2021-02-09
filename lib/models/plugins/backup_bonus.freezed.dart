// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'backup_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BackupBonusPlugin _$BackupBonusPluginFromJson(Map<String, dynamic> json) {
  return _BackupBonusPlugin.fromJson(json);
}

/// @nodoc
class _$BackupBonusPluginTearOff {
  const _$BackupBonusPluginTearOff();

// ignore: unused_element
  _BackupBonusPlugin call(
      {String type = 'backupBonus',
      String amount,
      String name,
      bool isActive}) {
    return _BackupBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

// ignore: unused_element
  BackupBonusPlugin fromJson(Map<String, Object> json) {
    return BackupBonusPlugin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $BackupBonusPlugin = _$BackupBonusPluginTearOff();

/// @nodoc
mixin _$BackupBonusPlugin {
  String get type;
  String get amount;
  String get name;
  bool get isActive;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $BackupBonusPluginCopyWith<BackupBonusPlugin> get copyWith;
}

/// @nodoc
abstract class $BackupBonusPluginCopyWith<$Res> {
  factory $BackupBonusPluginCopyWith(
          BackupBonusPlugin value, $Res Function(BackupBonusPlugin) then) =
      _$BackupBonusPluginCopyWithImpl<$Res>;
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class _$BackupBonusPluginCopyWithImpl<$Res>
    implements $BackupBonusPluginCopyWith<$Res> {
  _$BackupBonusPluginCopyWithImpl(this._value, this._then);

  final BackupBonusPlugin _value;
  // ignore: unused_field
  final $Res Function(BackupBonusPlugin) _then;

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
abstract class _$BackupBonusPluginCopyWith<$Res>
    implements $BackupBonusPluginCopyWith<$Res> {
  factory _$BackupBonusPluginCopyWith(
          _BackupBonusPlugin value, $Res Function(_BackupBonusPlugin) then) =
      __$BackupBonusPluginCopyWithImpl<$Res>;
  @override
  $Res call({String type, String amount, String name, bool isActive});
}

/// @nodoc
class __$BackupBonusPluginCopyWithImpl<$Res>
    extends _$BackupBonusPluginCopyWithImpl<$Res>
    implements _$BackupBonusPluginCopyWith<$Res> {
  __$BackupBonusPluginCopyWithImpl(
      _BackupBonusPlugin _value, $Res Function(_BackupBonusPlugin) _then)
      : super(_value, (v) => _then(v as _BackupBonusPlugin));

  @override
  _BackupBonusPlugin get _value => super._value as _BackupBonusPlugin;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
    Object name = freezed,
    Object isActive = freezed,
  }) {
    return _then(_BackupBonusPlugin(
      type: type == freezed ? _value.type : type as String,
      amount: amount == freezed ? _value.amount : amount as String,
      name: name == freezed ? _value.name : name as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }
}

@Implements(Plugin)
@JsonSerializable(createFactory: false)

/// @nodoc
class _$_BackupBonusPlugin implements _BackupBonusPlugin {
  _$_BackupBonusPlugin(
      {this.type = 'backupBonus', this.amount, this.name, this.isActive})
      : assert(type != null);

  factory _$_BackupBonusPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_BackupBonusPluginFromJson(json);

  @JsonKey(defaultValue: 'backupBonus')
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
    return 'BackupBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BackupBonusPlugin &&
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
  _$BackupBonusPluginCopyWith<_BackupBonusPlugin> get copyWith =>
      __$BackupBonusPluginCopyWithImpl<_BackupBonusPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BackupBonusPluginToJson(this);
  }
}

abstract class _BackupBonusPlugin implements BackupBonusPlugin, Plugin {
  factory _BackupBonusPlugin(
      {String type,
      String amount,
      String name,
      bool isActive}) = _$_BackupBonusPlugin;

  factory _BackupBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_BackupBonusPlugin.fromJson;

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
  _$BackupBonusPluginCopyWith<_BackupBonusPlugin> get copyWith;
}

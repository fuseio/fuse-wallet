// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'backup_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BackupBonusPlugin _$BackupBonusPluginFromJson(Map<String, dynamic> json) {
  return _BackupBonusPlugin.fromJson(json);
}

/// @nodoc
class _$BackupBonusPluginTearOff {
  const _$BackupBonusPluginTearOff();

  _BackupBonusPlugin call(
      {String type = 'backupBonus',
      String? amount = null,
      String? name = null,
      bool isActive = false}) {
    return _BackupBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

  BackupBonusPlugin fromJson(Map<String, Object> json) {
    return BackupBonusPlugin.fromJson(json);
  }
}

/// @nodoc
const $BackupBonusPlugin = _$BackupBonusPluginTearOff();

/// @nodoc
mixin _$BackupBonusPlugin {
  String get type => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BackupBonusPluginCopyWith<BackupBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupBonusPluginCopyWith<$Res> {
  factory $BackupBonusPluginCopyWith(
          BackupBonusPlugin value, $Res Function(BackupBonusPlugin) then) =
      _$BackupBonusPluginCopyWithImpl<$Res>;
  $Res call({String type, String? amount, String? name, bool isActive});
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
    Object? type = freezed,
    Object? amount = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({String type, String? amount, String? name, bool isActive});
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
    Object? type = freezed,
    Object? amount = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_BackupBonusPlugin(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@Implements(Plugin)
@JsonSerializable()
class _$_BackupBonusPlugin
    with DiagnosticableTreeMixin
    implements _BackupBonusPlugin {
  _$_BackupBonusPlugin(
      {this.type = 'backupBonus',
      this.amount = null,
      this.name = null,
      this.isActive = false});

  factory _$_BackupBonusPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_BackupBonusPluginFromJson(json);

  @JsonKey(defaultValue: 'backupBonus')
  @override
  final String type;
  @JsonKey(defaultValue: null)
  @override
  final String? amount;
  @JsonKey(defaultValue: null)
  @override
  final String? name;
  @JsonKey(defaultValue: false)
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackupBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackupBonusPlugin'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isActive', isActive));
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
      String? amount,
      String? name,
      bool isActive}) = _$_BackupBonusPlugin;

  factory _BackupBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_BackupBonusPlugin.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String? get amount => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BackupBonusPluginCopyWith<_BackupBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

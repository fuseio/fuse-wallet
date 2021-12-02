// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'join_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinBonusPlugin _$JoinBonusPluginFromJson(Map<String, dynamic> json) {
  return _JoinBonusPlugin.fromJson(json);
}

/// @nodoc
class _$JoinBonusPluginTearOff {
  const _$JoinBonusPluginTearOff();

  _JoinBonusPlugin call(
      {String type = 'joinBonus',
      String? amount,
      String? name,
      bool isActive = false}) {
    return _JoinBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

  JoinBonusPlugin fromJson(Map<String, Object?> json) {
    return JoinBonusPlugin.fromJson(json);
  }
}

/// @nodoc
const $JoinBonusPlugin = _$JoinBonusPluginTearOff();

/// @nodoc
mixin _$JoinBonusPlugin {
  String get type => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinBonusPluginCopyWith<JoinBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinBonusPluginCopyWith<$Res> {
  factory $JoinBonusPluginCopyWith(
          JoinBonusPlugin value, $Res Function(JoinBonusPlugin) then) =
      _$JoinBonusPluginCopyWithImpl<$Res>;
  $Res call({String type, String? amount, String? name, bool isActive});
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
abstract class _$JoinBonusPluginCopyWith<$Res>
    implements $JoinBonusPluginCopyWith<$Res> {
  factory _$JoinBonusPluginCopyWith(
          _JoinBonusPlugin value, $Res Function(_JoinBonusPlugin) then) =
      __$JoinBonusPluginCopyWithImpl<$Res>;
  @override
  $Res call({String type, String? amount, String? name, bool isActive});
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
    Object? type = freezed,
    Object? amount = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_JoinBonusPlugin(
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

@Implements<Plugin>()
@JsonSerializable()
class _$_JoinBonusPlugin
    with DiagnosticableTreeMixin
    implements _JoinBonusPlugin {
  _$_JoinBonusPlugin(
      {this.type = 'joinBonus', this.amount, this.name, this.isActive = false});

  factory _$_JoinBonusPlugin.fromJson(Map<String, dynamic> json) =>
      _$$_JoinBonusPluginFromJson(json);

  @JsonKey(defaultValue: 'joinBonus')
  @override
  final String type;
  @override
  final String? amount;
  @override
  final String? name;
  @JsonKey(defaultValue: false)
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JoinBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JoinBonusPlugin'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JoinBonusPlugin &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, amount, name, isActive);

  @JsonKey(ignore: true)
  @override
  _$JoinBonusPluginCopyWith<_JoinBonusPlugin> get copyWith =>
      __$JoinBonusPluginCopyWithImpl<_JoinBonusPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JoinBonusPluginToJson(this);
  }
}

abstract class _JoinBonusPlugin implements JoinBonusPlugin, Plugin {
  factory _JoinBonusPlugin(
      {String type,
      String? amount,
      String? name,
      bool isActive}) = _$_JoinBonusPlugin;

  factory _JoinBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_JoinBonusPlugin.fromJson;

  @override
  String get type;
  @override
  String? get amount;
  @override
  String? get name;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$JoinBonusPluginCopyWith<_JoinBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

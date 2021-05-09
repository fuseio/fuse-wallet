// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'invite_bonus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InviteBonusPlugin _$InviteBonusPluginFromJson(Map<String, dynamic> json) {
  return _InviteBonusPlugin.fromJson(json);
}

/// @nodoc
class _$InviteBonusPluginTearOff {
  const _$InviteBonusPluginTearOff();

  _InviteBonusPlugin call(
      {String type = 'inviteBonus',
      required String amount,
      required String name,
      required bool isActive}) {
    return _InviteBonusPlugin(
      type: type,
      amount: amount,
      name: name,
      isActive: isActive,
    );
  }

  InviteBonusPlugin fromJson(Map<String, Object> json) {
    return InviteBonusPlugin.fromJson(json);
  }
}

/// @nodoc
const $InviteBonusPlugin = _$InviteBonusPluginTearOff();

/// @nodoc
mixin _$InviteBonusPlugin {
  String get type => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InviteBonusPluginCopyWith<InviteBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
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
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
    Object? type = freezed,
    Object? amount = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_InviteBonusPlugin(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_InviteBonusPlugin
    with DiagnosticableTreeMixin
    implements _InviteBonusPlugin {
  _$_InviteBonusPlugin(
      {this.type = 'inviteBonus',
      required this.amount,
      required this.name,
      required this.isActive});

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InviteBonusPlugin(type: $type, amount: $amount, name: $name, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InviteBonusPlugin'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isActive', isActive));
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
      required String amount,
      required String name,
      required bool isActive}) = _$_InviteBonusPlugin;

  factory _InviteBonusPlugin.fromJson(Map<String, dynamic> json) =
      _$_InviteBonusPlugin.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get amount => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InviteBonusPluginCopyWith<_InviteBonusPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

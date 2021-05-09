// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rampInstant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RampInstantPlugin _$RampInstantPluginFromJson(Map<String, dynamic> json) {
  return _RampInstantPlugin.fromJson(json);
}

/// @nodoc
class _$RampInstantPluginTearOff {
  const _$RampInstantPluginTearOff();

  _RampInstantPlugin call(
      {required String name,
      required String widgetUrl,
      String type = 'deposit',
      bool isActive = false}) {
    return _RampInstantPlugin(
      name: name,
      widgetUrl: widgetUrl,
      type: type,
      isActive: isActive,
    );
  }

  RampInstantPlugin fromJson(Map<String, Object> json) {
    return RampInstantPlugin.fromJson(json);
  }
}

/// @nodoc
const $RampInstantPlugin = _$RampInstantPluginTearOff();

/// @nodoc
mixin _$RampInstantPlugin {
  String get name => throw _privateConstructorUsedError;
  String get widgetUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RampInstantPluginCopyWith<RampInstantPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RampInstantPluginCopyWith<$Res> {
  factory $RampInstantPluginCopyWith(
          RampInstantPlugin value, $Res Function(RampInstantPlugin) then) =
      _$RampInstantPluginCopyWithImpl<$Res>;
  $Res call({String name, String widgetUrl, String type, bool isActive});
}

/// @nodoc
class _$RampInstantPluginCopyWithImpl<$Res>
    implements $RampInstantPluginCopyWith<$Res> {
  _$RampInstantPluginCopyWithImpl(this._value, this._then);

  final RampInstantPlugin _value;
  // ignore: unused_field
  final $Res Function(RampInstantPlugin) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? widgetUrl = freezed,
    Object? type = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetUrl: widgetUrl == freezed
          ? _value.widgetUrl
          : widgetUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RampInstantPluginCopyWith<$Res>
    implements $RampInstantPluginCopyWith<$Res> {
  factory _$RampInstantPluginCopyWith(
          _RampInstantPlugin value, $Res Function(_RampInstantPlugin) then) =
      __$RampInstantPluginCopyWithImpl<$Res>;
  @override
  $Res call({String name, String widgetUrl, String type, bool isActive});
}

/// @nodoc
class __$RampInstantPluginCopyWithImpl<$Res>
    extends _$RampInstantPluginCopyWithImpl<$Res>
    implements _$RampInstantPluginCopyWith<$Res> {
  __$RampInstantPluginCopyWithImpl(
      _RampInstantPlugin _value, $Res Function(_RampInstantPlugin) _then)
      : super(_value, (v) => _then(v as _RampInstantPlugin));

  @override
  _RampInstantPlugin get _value => super._value as _RampInstantPlugin;

  @override
  $Res call({
    Object? name = freezed,
    Object? widgetUrl = freezed,
    Object? type = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_RampInstantPlugin(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetUrl: widgetUrl == freezed
          ? _value.widgetUrl
          : widgetUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
class _$_RampInstantPlugin
    with DiagnosticableTreeMixin
    implements _RampInstantPlugin {
  _$_RampInstantPlugin(
      {required this.name,
      required this.widgetUrl,
      this.type = 'deposit',
      this.isActive = false});

  factory _$_RampInstantPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_RampInstantPluginFromJson(json);

  @override
  final String name;
  @override
  final String widgetUrl;
  @JsonKey(defaultValue: 'deposit')
  @override
  final String type;
  @JsonKey(defaultValue: false)
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RampInstantPlugin(name: $name, widgetUrl: $widgetUrl, type: $type, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RampInstantPlugin'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('widgetUrl', widgetUrl))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RampInstantPlugin &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.widgetUrl, widgetUrl) ||
                const DeepCollectionEquality()
                    .equals(other.widgetUrl, widgetUrl)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(widgetUrl) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isActive);

  @JsonKey(ignore: true)
  @override
  _$RampInstantPluginCopyWith<_RampInstantPlugin> get copyWith =>
      __$RampInstantPluginCopyWithImpl<_RampInstantPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RampInstantPluginToJson(this);
  }
}

abstract class _RampInstantPlugin implements RampInstantPlugin, Plugin {
  factory _RampInstantPlugin(
      {required String name,
      required String widgetUrl,
      String type,
      bool isActive}) = _$_RampInstantPlugin;

  factory _RampInstantPlugin.fromJson(Map<String, dynamic> json) =
      _$_RampInstantPlugin.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get widgetUrl => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RampInstantPluginCopyWith<_RampInstantPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

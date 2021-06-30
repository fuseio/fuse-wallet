// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'moonpay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoonpayPlugin _$MoonpayPluginFromJson(Map<String, dynamic> json) {
  return _MoonpayPlugin.fromJson(json);
}

/// @nodoc
class _$MoonpayPluginTearOff {
  const _$MoonpayPluginTearOff();

  _MoonpayPlugin call(
      {String name = 'moonpay',
      String? widgetUrl,
      String type = 'deposit',
      bool isActive = false}) {
    return _MoonpayPlugin(
      name: name,
      widgetUrl: widgetUrl,
      type: type,
      isActive: isActive,
    );
  }

  MoonpayPlugin fromJson(Map<String, Object> json) {
    return MoonpayPlugin.fromJson(json);
  }
}

/// @nodoc
const $MoonpayPlugin = _$MoonpayPluginTearOff();

/// @nodoc
mixin _$MoonpayPlugin {
  String get name => throw _privateConstructorUsedError;
  String? get widgetUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoonpayPluginCopyWith<MoonpayPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoonpayPluginCopyWith<$Res> {
  factory $MoonpayPluginCopyWith(
          MoonpayPlugin value, $Res Function(MoonpayPlugin) then) =
      _$MoonpayPluginCopyWithImpl<$Res>;
  $Res call({String name, String? widgetUrl, String type, bool isActive});
}

/// @nodoc
class _$MoonpayPluginCopyWithImpl<$Res>
    implements $MoonpayPluginCopyWith<$Res> {
  _$MoonpayPluginCopyWithImpl(this._value, this._then);

  final MoonpayPlugin _value;
  // ignore: unused_field
  final $Res Function(MoonpayPlugin) _then;

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
              as String?,
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
abstract class _$MoonpayPluginCopyWith<$Res>
    implements $MoonpayPluginCopyWith<$Res> {
  factory _$MoonpayPluginCopyWith(
          _MoonpayPlugin value, $Res Function(_MoonpayPlugin) then) =
      __$MoonpayPluginCopyWithImpl<$Res>;
  @override
  $Res call({String name, String? widgetUrl, String type, bool isActive});
}

/// @nodoc
class __$MoonpayPluginCopyWithImpl<$Res>
    extends _$MoonpayPluginCopyWithImpl<$Res>
    implements _$MoonpayPluginCopyWith<$Res> {
  __$MoonpayPluginCopyWithImpl(
      _MoonpayPlugin _value, $Res Function(_MoonpayPlugin) _then)
      : super(_value, (v) => _then(v as _MoonpayPlugin));

  @override
  _MoonpayPlugin get _value => super._value as _MoonpayPlugin;

  @override
  $Res call({
    Object? name = freezed,
    Object? widgetUrl = freezed,
    Object? type = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_MoonpayPlugin(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetUrl: widgetUrl == freezed
          ? _value.widgetUrl
          : widgetUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_MoonpayPlugin with DiagnosticableTreeMixin implements _MoonpayPlugin {
  _$_MoonpayPlugin(
      {this.name = 'moonpay',
      this.widgetUrl,
      this.type = 'deposit',
      this.isActive = false});

  factory _$_MoonpayPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_MoonpayPluginFromJson(json);

  @JsonKey(defaultValue: 'moonpay')
  @override
  final String name;
  @override
  final String? widgetUrl;
  @JsonKey(defaultValue: 'deposit')
  @override
  final String type;
  @JsonKey(defaultValue: false)
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoonpayPlugin(name: $name, widgetUrl: $widgetUrl, type: $type, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoonpayPlugin'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('widgetUrl', widgetUrl))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoonpayPlugin &&
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
  _$MoonpayPluginCopyWith<_MoonpayPlugin> get copyWith =>
      __$MoonpayPluginCopyWithImpl<_MoonpayPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoonpayPluginToJson(this);
  }
}

abstract class _MoonpayPlugin implements MoonpayPlugin, Plugin {
  factory _MoonpayPlugin(
      {String name,
      String? widgetUrl,
      String type,
      bool isActive}) = _$_MoonpayPlugin;

  factory _MoonpayPlugin.fromJson(Map<String, dynamic> json) =
      _$_MoonpayPlugin.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get widgetUrl => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoonpayPluginCopyWith<_MoonpayPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

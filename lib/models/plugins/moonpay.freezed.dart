// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'moonpay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MoonpayPlugin _$MoonpayPluginFromJson(Map<String, dynamic> json) {
  return _MoonpayPlugin.fromJson(json);
}

/// @nodoc
class _$MoonpayPluginTearOff {
  const _$MoonpayPluginTearOff();

// ignore: unused_element
  _MoonpayPlugin call(
      {String name,
      String widgetUrl,
      String type = 'deposit',
      bool isActive = false}) {
    return _MoonpayPlugin(
      name: name,
      widgetUrl: widgetUrl,
      type: type,
      isActive: isActive,
    );
  }

// ignore: unused_element
  MoonpayPlugin fromJson(Map<String, Object> json) {
    return MoonpayPlugin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $MoonpayPlugin = _$MoonpayPluginTearOff();

/// @nodoc
mixin _$MoonpayPlugin {
  String get name;
  String get widgetUrl;
  String get type;
  bool get isActive;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $MoonpayPluginCopyWith<MoonpayPlugin> get copyWith;
}

/// @nodoc
abstract class $MoonpayPluginCopyWith<$Res> {
  factory $MoonpayPluginCopyWith(
          MoonpayPlugin value, $Res Function(MoonpayPlugin) then) =
      _$MoonpayPluginCopyWithImpl<$Res>;
  $Res call({String name, String widgetUrl, String type, bool isActive});
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
    Object name = freezed,
    Object widgetUrl = freezed,
    Object type = freezed,
    Object isActive = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      widgetUrl: widgetUrl == freezed ? _value.widgetUrl : widgetUrl as String,
      type: type == freezed ? _value.type : type as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
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
  $Res call({String name, String widgetUrl, String type, bool isActive});
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
    Object name = freezed,
    Object widgetUrl = freezed,
    Object type = freezed,
    Object isActive = freezed,
  }) {
    return _then(_MoonpayPlugin(
      name: name == freezed ? _value.name : name as String,
      widgetUrl: widgetUrl == freezed ? _value.widgetUrl : widgetUrl as String,
      type: type == freezed ? _value.type : type as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
    ));
  }
}

@Implements(Plugin)
@JsonSerializable(createFactory: false)

/// @nodoc
class _$_MoonpayPlugin implements _MoonpayPlugin {
  _$_MoonpayPlugin(
      {this.name, this.widgetUrl, this.type = 'deposit', this.isActive = false})
      : assert(type != null),
        assert(isActive != null);

  factory _$_MoonpayPlugin.fromJson(Map<String, dynamic> json) =>
      _$_$_MoonpayPluginFromJson(json);

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
  String toString() {
    return 'MoonpayPlugin(name: $name, widgetUrl: $widgetUrl, type: $type, isActive: $isActive)';
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
      String widgetUrl,
      String type,
      bool isActive}) = _$_MoonpayPlugin;

  factory _MoonpayPlugin.fromJson(Map<String, dynamic> json) =
      _$_MoonpayPlugin.fromJson;

  @override
  String get name;
  @override
  String get widgetUrl;
  @override
  String get type;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$MoonpayPluginCopyWith<_MoonpayPlugin> get copyWith;
}

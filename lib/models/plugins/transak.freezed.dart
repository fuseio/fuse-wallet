// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransakPlugin _$TransakPluginFromJson(Map<String, dynamic> json) {
  return _TransakPlugin.fromJson(json);
}

/// @nodoc
class _$TransakPluginTearOff {
  const _$TransakPluginTearOff();

  _TransakPlugin call(
      {String name = 'transak',
      String? widgetUrl,
      String type = 'deposit',
      bool isActive = false}) {
    return _TransakPlugin(
      name: name,
      widgetUrl: widgetUrl,
      type: type,
      isActive: isActive,
    );
  }

  TransakPlugin fromJson(Map<String, Object?> json) {
    return TransakPlugin.fromJson(json);
  }
}

/// @nodoc
const $TransakPlugin = _$TransakPluginTearOff();

/// @nodoc
mixin _$TransakPlugin {
  String get name => throw _privateConstructorUsedError;
  String? get widgetUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransakPluginCopyWith<TransakPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransakPluginCopyWith<$Res> {
  factory $TransakPluginCopyWith(
          TransakPlugin value, $Res Function(TransakPlugin) then) =
      _$TransakPluginCopyWithImpl<$Res>;
  $Res call({String name, String? widgetUrl, String type, bool isActive});
}

/// @nodoc
class _$TransakPluginCopyWithImpl<$Res>
    implements $TransakPluginCopyWith<$Res> {
  _$TransakPluginCopyWithImpl(this._value, this._then);

  final TransakPlugin _value;
  // ignore: unused_field
  final $Res Function(TransakPlugin) _then;

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
abstract class _$TransakPluginCopyWith<$Res>
    implements $TransakPluginCopyWith<$Res> {
  factory _$TransakPluginCopyWith(
          _TransakPlugin value, $Res Function(_TransakPlugin) then) =
      __$TransakPluginCopyWithImpl<$Res>;
  @override
  $Res call({String name, String? widgetUrl, String type, bool isActive});
}

/// @nodoc
class __$TransakPluginCopyWithImpl<$Res>
    extends _$TransakPluginCopyWithImpl<$Res>
    implements _$TransakPluginCopyWith<$Res> {
  __$TransakPluginCopyWithImpl(
      _TransakPlugin _value, $Res Function(_TransakPlugin) _then)
      : super(_value, (v) => _then(v as _TransakPlugin));

  @override
  _TransakPlugin get _value => super._value as _TransakPlugin;

  @override
  $Res call({
    Object? name = freezed,
    Object? widgetUrl = freezed,
    Object? type = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_TransakPlugin(
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

@Implements<Plugin>()
@JsonSerializable()
class _$_TransakPlugin with DiagnosticableTreeMixin implements _TransakPlugin {
  _$_TransakPlugin(
      {this.name = 'transak',
      this.widgetUrl,
      this.type = 'deposit',
      this.isActive = false});

  factory _$_TransakPlugin.fromJson(Map<String, dynamic> json) =>
      _$$_TransakPluginFromJson(json);

  @JsonKey()
  @override
  final String name;
  @override
  final String? widgetUrl;
  @JsonKey()
  @override
  final String type;
  @JsonKey()
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransakPlugin(name: $name, widgetUrl: $widgetUrl, type: $type, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransakPlugin'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('widgetUrl', widgetUrl))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransakPlugin &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.widgetUrl, widgetUrl) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.isActive, isActive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(widgetUrl),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isActive));

  @JsonKey(ignore: true)
  @override
  _$TransakPluginCopyWith<_TransakPlugin> get copyWith =>
      __$TransakPluginCopyWithImpl<_TransakPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransakPluginToJson(this);
  }
}

abstract class _TransakPlugin implements TransakPlugin, Plugin {
  factory _TransakPlugin(
      {String name,
      String? widgetUrl,
      String type,
      bool isActive}) = _$_TransakPlugin;

  factory _TransakPlugin.fromJson(Map<String, dynamic> json) =
      _$_TransakPlugin.fromJson;

  @override
  String get name;
  @override
  String? get widgetUrl;
  @override
  String get type;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$TransakPluginCopyWith<_TransakPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

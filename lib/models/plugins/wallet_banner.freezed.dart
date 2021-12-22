// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletBannerPlugin _$WalletBannerPluginFromJson(Map<String, dynamic> json) {
  return _WalletBannerPlugin.fromJson(json);
}

/// @nodoc
class _$WalletBannerPluginTearOff {
  const _$WalletBannerPluginTearOff();

  _WalletBannerPlugin call(
      {String type = 'walletBanner',
      String? walletBannerHash,
      String? name,
      String? link,
      bool isActive = false}) {
    return _WalletBannerPlugin(
      type: type,
      walletBannerHash: walletBannerHash,
      name: name,
      link: link,
      isActive: isActive,
    );
  }

  WalletBannerPlugin fromJson(Map<String, Object?> json) {
    return WalletBannerPlugin.fromJson(json);
  }
}

/// @nodoc
const $WalletBannerPlugin = _$WalletBannerPluginTearOff();

/// @nodoc
mixin _$WalletBannerPlugin {
  String get type => throw _privateConstructorUsedError;
  String? get walletBannerHash => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletBannerPluginCopyWith<WalletBannerPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletBannerPluginCopyWith<$Res> {
  factory $WalletBannerPluginCopyWith(
          WalletBannerPlugin value, $Res Function(WalletBannerPlugin) then) =
      _$WalletBannerPluginCopyWithImpl<$Res>;
  $Res call(
      {String type,
      String? walletBannerHash,
      String? name,
      String? link,
      bool isActive});
}

/// @nodoc
class _$WalletBannerPluginCopyWithImpl<$Res>
    implements $WalletBannerPluginCopyWith<$Res> {
  _$WalletBannerPluginCopyWithImpl(this._value, this._then);

  final WalletBannerPlugin _value;
  // ignore: unused_field
  final $Res Function(WalletBannerPlugin) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? walletBannerHash = freezed,
    Object? name = freezed,
    Object? link = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      walletBannerHash: walletBannerHash == freezed
          ? _value.walletBannerHash
          : walletBannerHash // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$WalletBannerPluginCopyWith<$Res>
    implements $WalletBannerPluginCopyWith<$Res> {
  factory _$WalletBannerPluginCopyWith(
          _WalletBannerPlugin value, $Res Function(_WalletBannerPlugin) then) =
      __$WalletBannerPluginCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      String? walletBannerHash,
      String? name,
      String? link,
      bool isActive});
}

/// @nodoc
class __$WalletBannerPluginCopyWithImpl<$Res>
    extends _$WalletBannerPluginCopyWithImpl<$Res>
    implements _$WalletBannerPluginCopyWith<$Res> {
  __$WalletBannerPluginCopyWithImpl(
      _WalletBannerPlugin _value, $Res Function(_WalletBannerPlugin) _then)
      : super(_value, (v) => _then(v as _WalletBannerPlugin));

  @override
  _WalletBannerPlugin get _value => super._value as _WalletBannerPlugin;

  @override
  $Res call({
    Object? type = freezed,
    Object? walletBannerHash = freezed,
    Object? name = freezed,
    Object? link = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_WalletBannerPlugin(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      walletBannerHash: walletBannerHash == freezed
          ? _value.walletBannerHash
          : walletBannerHash // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
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
class _$_WalletBannerPlugin
    with DiagnosticableTreeMixin
    implements _WalletBannerPlugin {
  _$_WalletBannerPlugin(
      {this.type = 'walletBanner',
      this.walletBannerHash,
      this.name,
      this.link,
      this.isActive = false});

  factory _$_WalletBannerPlugin.fromJson(Map<String, dynamic> json) =>
      _$$_WalletBannerPluginFromJson(json);

  @JsonKey()
  @override
  final String type;
  @override
  final String? walletBannerHash;
  @override
  final String? name;
  @override
  final String? link;
  @JsonKey()
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletBannerPlugin(type: $type, walletBannerHash: $walletBannerHash, name: $name, link: $link, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletBannerPlugin'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('walletBannerHash', walletBannerHash))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WalletBannerPlugin &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.walletBannerHash, walletBannerHash) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.link, link) &&
            const DeepCollectionEquality().equals(other.isActive, isActive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(walletBannerHash),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(link),
      const DeepCollectionEquality().hash(isActive));

  @JsonKey(ignore: true)
  @override
  _$WalletBannerPluginCopyWith<_WalletBannerPlugin> get copyWith =>
      __$WalletBannerPluginCopyWithImpl<_WalletBannerPlugin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletBannerPluginToJson(this);
  }
}

abstract class _WalletBannerPlugin implements WalletBannerPlugin, Plugin {
  factory _WalletBannerPlugin(
      {String type,
      String? walletBannerHash,
      String? name,
      String? link,
      bool isActive}) = _$_WalletBannerPlugin;

  factory _WalletBannerPlugin.fromJson(Map<String, dynamic> json) =
      _$_WalletBannerPlugin.fromJson;

  @override
  String get type;
  @override
  String? get walletBannerHash;
  @override
  String? get name;
  @override
  String? get link;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$WalletBannerPluginCopyWith<_WalletBannerPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

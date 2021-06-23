// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return _Community.fromJson(json);
}

/// @nodoc
class _$CommunityTearOff {
  const _$CommunityTearOff();

  _Community call(
      {String name = '',
      String address = '',
      bool isMultiBridge = false,
      bool isClosed = false,
      bool isMember = false,
      @JsonKey(includeIfNull: false) String homeTokenAddress = '',
      @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
      @JsonKey(includeIfNull: false) String? webUrl,
      @JsonKey(includeIfNull: false) String? bridgeType,
      @JsonKey(includeIfNull: false) String? bridgeDirection,
      @JsonKey(includeIfNull: false) String? homeBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignTokenAddress,
      @JsonKey(includeIfNull: false) @PluginsConverter() Plugins? plugins,
      @JsonKey(includeIfNull: false) List<Business>? businesses,
      @JsonKey(includeIfNull: false) String? description}) {
    return _Community(
      name: name,
      address: address,
      isMultiBridge: isMultiBridge,
      isClosed: isClosed,
      isMember: isMember,
      homeTokenAddress: homeTokenAddress,
      metadata: metadata,
      webUrl: webUrl,
      bridgeType: bridgeType,
      bridgeDirection: bridgeDirection,
      homeBridgeAddress: homeBridgeAddress,
      foreignBridgeAddress: foreignBridgeAddress,
      foreignTokenAddress: foreignTokenAddress,
      plugins: plugins,
      businesses: businesses,
      description: description,
    );
  }

  Community fromJson(Map<String, Object> json) {
    return Community.fromJson(json);
  }
}

/// @nodoc
const $Community = _$CommunityTearOff();

/// @nodoc
mixin _$Community {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get isMultiBridge => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;
  bool get isMember => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String get homeTokenAddress => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  CommunityMetadata? get metadata => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get webUrl => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get bridgeType => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get bridgeDirection => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get homeBridgeAddress => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get foreignBridgeAddress => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get foreignTokenAddress => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  @PluginsConverter()
  Plugins? get plugins => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  List<Business>? get businesses => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommunityCopyWith<Community> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityCopyWith<$Res> {
  factory $CommunityCopyWith(Community value, $Res Function(Community) then) =
      _$CommunityCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String address,
      bool isMultiBridge,
      bool isClosed,
      bool isMember,
      @JsonKey(includeIfNull: false) String homeTokenAddress,
      @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
      @JsonKey(includeIfNull: false) String? webUrl,
      @JsonKey(includeIfNull: false) String? bridgeType,
      @JsonKey(includeIfNull: false) String? bridgeDirection,
      @JsonKey(includeIfNull: false) String? homeBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignTokenAddress,
      @JsonKey(includeIfNull: false) @PluginsConverter() Plugins? plugins,
      @JsonKey(includeIfNull: false) List<Business>? businesses,
      @JsonKey(includeIfNull: false) String? description});

  $CommunityMetadataCopyWith<$Res>? get metadata;
  $PluginsCopyWith<$Res>? get plugins;
}

/// @nodoc
class _$CommunityCopyWithImpl<$Res> implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._value, this._then);

  final Community _value;
  // ignore: unused_field
  final $Res Function(Community) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
    Object? isMultiBridge = freezed,
    Object? isClosed = freezed,
    Object? isMember = freezed,
    Object? homeTokenAddress = freezed,
    Object? metadata = freezed,
    Object? webUrl = freezed,
    Object? bridgeType = freezed,
    Object? bridgeDirection = freezed,
    Object? homeBridgeAddress = freezed,
    Object? foreignBridgeAddress = freezed,
    Object? foreignTokenAddress = freezed,
    Object? plugins = freezed,
    Object? businesses = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isMultiBridge: isMultiBridge == freezed
          ? _value.isMultiBridge
          : isMultiBridge // ignore: cast_nullable_to_non_nullable
              as bool,
      isClosed: isClosed == freezed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      isMember: isMember == freezed
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
      homeTokenAddress: homeTokenAddress == freezed
          ? _value.homeTokenAddress
          : homeTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as CommunityMetadata?,
      webUrl: webUrl == freezed
          ? _value.webUrl
          : webUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bridgeType: bridgeType == freezed
          ? _value.bridgeType
          : bridgeType // ignore: cast_nullable_to_non_nullable
              as String?,
      bridgeDirection: bridgeDirection == freezed
          ? _value.bridgeDirection
          : bridgeDirection // ignore: cast_nullable_to_non_nullable
              as String?,
      homeBridgeAddress: homeBridgeAddress == freezed
          ? _value.homeBridgeAddress
          : homeBridgeAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignBridgeAddress: foreignBridgeAddress == freezed
          ? _value.foreignBridgeAddress
          : foreignBridgeAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignTokenAddress: foreignTokenAddress == freezed
          ? _value.foreignTokenAddress
          : foreignTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      plugins: plugins == freezed
          ? _value.plugins
          : plugins // ignore: cast_nullable_to_non_nullable
              as Plugins?,
      businesses: businesses == freezed
          ? _value.businesses
          : businesses // ignore: cast_nullable_to_non_nullable
              as List<Business>?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $CommunityMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $CommunityMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value));
    });
  }

  @override
  $PluginsCopyWith<$Res>? get plugins {
    if (_value.plugins == null) {
      return null;
    }

    return $PluginsCopyWith<$Res>(_value.plugins!, (value) {
      return _then(_value.copyWith(plugins: value));
    });
  }
}

/// @nodoc
abstract class _$CommunityCopyWith<$Res> implements $CommunityCopyWith<$Res> {
  factory _$CommunityCopyWith(
          _Community value, $Res Function(_Community) then) =
      __$CommunityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String address,
      bool isMultiBridge,
      bool isClosed,
      bool isMember,
      @JsonKey(includeIfNull: false) String homeTokenAddress,
      @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
      @JsonKey(includeIfNull: false) String? webUrl,
      @JsonKey(includeIfNull: false) String? bridgeType,
      @JsonKey(includeIfNull: false) String? bridgeDirection,
      @JsonKey(includeIfNull: false) String? homeBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignTokenAddress,
      @JsonKey(includeIfNull: false) @PluginsConverter() Plugins? plugins,
      @JsonKey(includeIfNull: false) List<Business>? businesses,
      @JsonKey(includeIfNull: false) String? description});

  @override
  $CommunityMetadataCopyWith<$Res>? get metadata;
  @override
  $PluginsCopyWith<$Res>? get plugins;
}

/// @nodoc
class __$CommunityCopyWithImpl<$Res> extends _$CommunityCopyWithImpl<$Res>
    implements _$CommunityCopyWith<$Res> {
  __$CommunityCopyWithImpl(_Community _value, $Res Function(_Community) _then)
      : super(_value, (v) => _then(v as _Community));

  @override
  _Community get _value => super._value as _Community;

  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
    Object? isMultiBridge = freezed,
    Object? isClosed = freezed,
    Object? isMember = freezed,
    Object? homeTokenAddress = freezed,
    Object? metadata = freezed,
    Object? webUrl = freezed,
    Object? bridgeType = freezed,
    Object? bridgeDirection = freezed,
    Object? homeBridgeAddress = freezed,
    Object? foreignBridgeAddress = freezed,
    Object? foreignTokenAddress = freezed,
    Object? plugins = freezed,
    Object? businesses = freezed,
    Object? description = freezed,
  }) {
    return _then(_Community(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isMultiBridge: isMultiBridge == freezed
          ? _value.isMultiBridge
          : isMultiBridge // ignore: cast_nullable_to_non_nullable
              as bool,
      isClosed: isClosed == freezed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      isMember: isMember == freezed
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
      homeTokenAddress: homeTokenAddress == freezed
          ? _value.homeTokenAddress
          : homeTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as CommunityMetadata?,
      webUrl: webUrl == freezed
          ? _value.webUrl
          : webUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bridgeType: bridgeType == freezed
          ? _value.bridgeType
          : bridgeType // ignore: cast_nullable_to_non_nullable
              as String?,
      bridgeDirection: bridgeDirection == freezed
          ? _value.bridgeDirection
          : bridgeDirection // ignore: cast_nullable_to_non_nullable
              as String?,
      homeBridgeAddress: homeBridgeAddress == freezed
          ? _value.homeBridgeAddress
          : homeBridgeAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignBridgeAddress: foreignBridgeAddress == freezed
          ? _value.foreignBridgeAddress
          : foreignBridgeAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignTokenAddress: foreignTokenAddress == freezed
          ? _value.foreignTokenAddress
          : foreignTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      plugins: plugins == freezed
          ? _value.plugins
          : plugins // ignore: cast_nullable_to_non_nullable
              as Plugins?,
      businesses: businesses == freezed
          ? _value.businesses
          : businesses // ignore: cast_nullable_to_non_nullable
              as List<Business>?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Community with DiagnosticableTreeMixin implements _Community {
  _$_Community(
      {this.name = '',
      this.address = '',
      this.isMultiBridge = false,
      this.isClosed = false,
      this.isMember = false,
      @JsonKey(includeIfNull: false) this.homeTokenAddress = '',
      @JsonKey(includeIfNull: false) this.metadata,
      @JsonKey(includeIfNull: false) this.webUrl,
      @JsonKey(includeIfNull: false) this.bridgeType,
      @JsonKey(includeIfNull: false) this.bridgeDirection,
      @JsonKey(includeIfNull: false) this.homeBridgeAddress,
      @JsonKey(includeIfNull: false) this.foreignBridgeAddress,
      @JsonKey(includeIfNull: false) this.foreignTokenAddress,
      @JsonKey(includeIfNull: false) @PluginsConverter() this.plugins,
      @JsonKey(includeIfNull: false) this.businesses,
      @JsonKey(includeIfNull: false) this.description});

  factory _$_Community.fromJson(Map<String, dynamic> json) =>
      _$_$_CommunityFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String name;
  @JsonKey(defaultValue: '')
  @override
  final String address;
  @JsonKey(defaultValue: false)
  @override
  final bool isMultiBridge;
  @JsonKey(defaultValue: false)
  @override
  final bool isClosed;
  @JsonKey(defaultValue: false)
  @override
  final bool isMember;
  @override
  @JsonKey(includeIfNull: false)
  final String homeTokenAddress;
  @override
  @JsonKey(includeIfNull: false)
  final CommunityMetadata? metadata;
  @override
  @JsonKey(includeIfNull: false)
  final String? webUrl;
  @override
  @JsonKey(includeIfNull: false)
  final String? bridgeType;
  @override
  @JsonKey(includeIfNull: false)
  final String? bridgeDirection;
  @override
  @JsonKey(includeIfNull: false)
  final String? homeBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  final String? foreignBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  final String? foreignTokenAddress;
  @override
  @JsonKey(includeIfNull: false)
  @PluginsConverter()
  final Plugins? plugins;
  @override
  @JsonKey(includeIfNull: false)
  final List<Business>? businesses;
  @override
  @JsonKey(includeIfNull: false)
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Community(name: $name, address: $address, isMultiBridge: $isMultiBridge, isClosed: $isClosed, isMember: $isMember, homeTokenAddress: $homeTokenAddress, metadata: $metadata, webUrl: $webUrl, bridgeType: $bridgeType, bridgeDirection: $bridgeDirection, homeBridgeAddress: $homeBridgeAddress, foreignBridgeAddress: $foreignBridgeAddress, foreignTokenAddress: $foreignTokenAddress, plugins: $plugins, businesses: $businesses, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Community'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('isMultiBridge', isMultiBridge))
      ..add(DiagnosticsProperty('isClosed', isClosed))
      ..add(DiagnosticsProperty('isMember', isMember))
      ..add(DiagnosticsProperty('homeTokenAddress', homeTokenAddress))
      ..add(DiagnosticsProperty('metadata', metadata))
      ..add(DiagnosticsProperty('webUrl', webUrl))
      ..add(DiagnosticsProperty('bridgeType', bridgeType))
      ..add(DiagnosticsProperty('bridgeDirection', bridgeDirection))
      ..add(DiagnosticsProperty('homeBridgeAddress', homeBridgeAddress))
      ..add(DiagnosticsProperty('foreignBridgeAddress', foreignBridgeAddress))
      ..add(DiagnosticsProperty('foreignTokenAddress', foreignTokenAddress))
      ..add(DiagnosticsProperty('plugins', plugins))
      ..add(DiagnosticsProperty('businesses', businesses))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Community &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.isMultiBridge, isMultiBridge) ||
                const DeepCollectionEquality()
                    .equals(other.isMultiBridge, isMultiBridge)) &&
            (identical(other.isClosed, isClosed) ||
                const DeepCollectionEquality()
                    .equals(other.isClosed, isClosed)) &&
            (identical(other.isMember, isMember) ||
                const DeepCollectionEquality()
                    .equals(other.isMember, isMember)) &&
            (identical(other.homeTokenAddress, homeTokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.homeTokenAddress, homeTokenAddress)) &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)) &&
            (identical(other.webUrl, webUrl) ||
                const DeepCollectionEquality().equals(other.webUrl, webUrl)) &&
            (identical(other.bridgeType, bridgeType) ||
                const DeepCollectionEquality()
                    .equals(other.bridgeType, bridgeType)) &&
            (identical(other.bridgeDirection, bridgeDirection) ||
                const DeepCollectionEquality()
                    .equals(other.bridgeDirection, bridgeDirection)) &&
            (identical(other.homeBridgeAddress, homeBridgeAddress) ||
                const DeepCollectionEquality()
                    .equals(other.homeBridgeAddress, homeBridgeAddress)) &&
            (identical(other.foreignBridgeAddress, foreignBridgeAddress) ||
                const DeepCollectionEquality().equals(
                    other.foreignBridgeAddress, foreignBridgeAddress)) &&
            (identical(other.foreignTokenAddress, foreignTokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.foreignTokenAddress, foreignTokenAddress)) &&
            (identical(other.plugins, plugins) ||
                const DeepCollectionEquality()
                    .equals(other.plugins, plugins)) &&
            (identical(other.businesses, businesses) ||
                const DeepCollectionEquality()
                    .equals(other.businesses, businesses)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(isMultiBridge) ^
      const DeepCollectionEquality().hash(isClosed) ^
      const DeepCollectionEquality().hash(isMember) ^
      const DeepCollectionEquality().hash(homeTokenAddress) ^
      const DeepCollectionEquality().hash(metadata) ^
      const DeepCollectionEquality().hash(webUrl) ^
      const DeepCollectionEquality().hash(bridgeType) ^
      const DeepCollectionEquality().hash(bridgeDirection) ^
      const DeepCollectionEquality().hash(homeBridgeAddress) ^
      const DeepCollectionEquality().hash(foreignBridgeAddress) ^
      const DeepCollectionEquality().hash(foreignTokenAddress) ^
      const DeepCollectionEquality().hash(plugins) ^
      const DeepCollectionEquality().hash(businesses) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  _$CommunityCopyWith<_Community> get copyWith =>
      __$CommunityCopyWithImpl<_Community>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CommunityToJson(this);
  }
}

abstract class _Community implements Community {
  factory _Community(
      {String name,
      String address,
      bool isMultiBridge,
      bool isClosed,
      bool isMember,
      @JsonKey(includeIfNull: false) String homeTokenAddress,
      @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
      @JsonKey(includeIfNull: false) String? webUrl,
      @JsonKey(includeIfNull: false) String? bridgeType,
      @JsonKey(includeIfNull: false) String? bridgeDirection,
      @JsonKey(includeIfNull: false) String? homeBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
      @JsonKey(includeIfNull: false) String? foreignTokenAddress,
      @JsonKey(includeIfNull: false) @PluginsConverter() Plugins? plugins,
      @JsonKey(includeIfNull: false) List<Business>? businesses,
      @JsonKey(includeIfNull: false) String? description}) = _$_Community;

  factory _Community.fromJson(Map<String, dynamic> json) =
      _$_Community.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  bool get isMultiBridge => throw _privateConstructorUsedError;
  @override
  bool get isClosed => throw _privateConstructorUsedError;
  @override
  bool get isMember => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String get homeTokenAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  CommunityMetadata? get metadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get webUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get bridgeType => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get bridgeDirection => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get homeBridgeAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get foreignBridgeAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get foreignTokenAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  @PluginsConverter()
  Plugins? get plugins => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  List<Business>? get businesses => throw _privateConstructorUsedError;
  @override
  @JsonKey(includeIfNull: false)
  String? get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommunityCopyWith<_Community> get copyWith =>
      throw _privateConstructorUsedError;
}

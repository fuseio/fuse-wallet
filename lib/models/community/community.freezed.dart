// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Community _$CommunityFromJson(Map<String, dynamic> json) {
  return _Community.fromJson(json);
}

/// @nodoc
class _$CommunityTearOff {
  const _$CommunityTearOff();

// ignore: unused_element
  _Community call(
      {String name,
      String address,
      bool isMultiBridge = false,
      bool isClosed = false,
      bool isMember = false,
      @nullable
          String homeTokenAddress,
      @nullable
          CommunityMetadata metadata,
      @nullable
          String webUrl,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeType,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeDirection,
      @JsonKey(includeIfNull: false)
      @nullable
          String homeBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignTokenAddress,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
          Plugins plugins,
      @nullable
      @JsonKey(includeIfNull: false)
          List<Business> businesses = const [],
      @nullable
          String description}) {
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

// ignore: unused_element
  Community fromJson(Map<String, Object> json) {
    return Community.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Community = _$CommunityTearOff();

/// @nodoc
mixin _$Community {
  String get name;
  String get address;
  bool get isMultiBridge;
  bool get isClosed;
  bool get isMember;
  @nullable
  String get homeTokenAddress;
  @nullable
  CommunityMetadata get metadata;
  @nullable
  String get webUrl;
  @JsonKey(includeIfNull: false)
  @nullable
  String get bridgeType;
  @JsonKey(includeIfNull: false)
  @nullable
  String get bridgeDirection;
  @JsonKey(includeIfNull: false)
  @nullable
  String get homeBridgeAddress;
  @JsonKey(includeIfNull: false)
  @nullable
  String get foreignBridgeAddress;
  @JsonKey(includeIfNull: false)
  @nullable
  String get foreignTokenAddress;
  @nullable
  @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
  Plugins get plugins;
  @nullable
  @JsonKey(includeIfNull: false)
  List<Business> get businesses;
  @nullable
  String get description;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CommunityCopyWith<Community> get copyWith;
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
      @nullable
          String homeTokenAddress,
      @nullable
          CommunityMetadata metadata,
      @nullable
          String webUrl,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeType,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeDirection,
      @JsonKey(includeIfNull: false)
      @nullable
          String homeBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignTokenAddress,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
          Plugins plugins,
      @nullable
      @JsonKey(includeIfNull: false)
          List<Business> businesses,
      @nullable
          String description});

  $CommunityMetadataCopyWith<$Res> get metadata;
  $PluginsCopyWith<$Res> get plugins;
}

/// @nodoc
class _$CommunityCopyWithImpl<$Res> implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._value, this._then);

  final Community _value;
  // ignore: unused_field
  final $Res Function(Community) _then;

  @override
  $Res call({
    Object name = freezed,
    Object address = freezed,
    Object isMultiBridge = freezed,
    Object isClosed = freezed,
    Object isMember = freezed,
    Object homeTokenAddress = freezed,
    Object metadata = freezed,
    Object webUrl = freezed,
    Object bridgeType = freezed,
    Object bridgeDirection = freezed,
    Object homeBridgeAddress = freezed,
    Object foreignBridgeAddress = freezed,
    Object foreignTokenAddress = freezed,
    Object plugins = freezed,
    Object businesses = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      address: address == freezed ? _value.address : address as String,
      isMultiBridge: isMultiBridge == freezed
          ? _value.isMultiBridge
          : isMultiBridge as bool,
      isClosed: isClosed == freezed ? _value.isClosed : isClosed as bool,
      isMember: isMember == freezed ? _value.isMember : isMember as bool,
      homeTokenAddress: homeTokenAddress == freezed
          ? _value.homeTokenAddress
          : homeTokenAddress as String,
      metadata:
          metadata == freezed ? _value.metadata : metadata as CommunityMetadata,
      webUrl: webUrl == freezed ? _value.webUrl : webUrl as String,
      bridgeType:
          bridgeType == freezed ? _value.bridgeType : bridgeType as String,
      bridgeDirection: bridgeDirection == freezed
          ? _value.bridgeDirection
          : bridgeDirection as String,
      homeBridgeAddress: homeBridgeAddress == freezed
          ? _value.homeBridgeAddress
          : homeBridgeAddress as String,
      foreignBridgeAddress: foreignBridgeAddress == freezed
          ? _value.foreignBridgeAddress
          : foreignBridgeAddress as String,
      foreignTokenAddress: foreignTokenAddress == freezed
          ? _value.foreignTokenAddress
          : foreignTokenAddress as String,
      plugins: plugins == freezed ? _value.plugins : plugins as Plugins,
      businesses: businesses == freezed
          ? _value.businesses
          : businesses as List<Business>,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }

  @override
  $CommunityMetadataCopyWith<$Res> get metadata {
    if (_value.metadata == null) {
      return null;
    }
    return $CommunityMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value));
    });
  }

  @override
  $PluginsCopyWith<$Res> get plugins {
    if (_value.plugins == null) {
      return null;
    }
    return $PluginsCopyWith<$Res>(_value.plugins, (value) {
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
      @nullable
          String homeTokenAddress,
      @nullable
          CommunityMetadata metadata,
      @nullable
          String webUrl,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeType,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeDirection,
      @JsonKey(includeIfNull: false)
      @nullable
          String homeBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignTokenAddress,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
          Plugins plugins,
      @nullable
      @JsonKey(includeIfNull: false)
          List<Business> businesses,
      @nullable
          String description});

  @override
  $CommunityMetadataCopyWith<$Res> get metadata;
  @override
  $PluginsCopyWith<$Res> get plugins;
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
    Object name = freezed,
    Object address = freezed,
    Object isMultiBridge = freezed,
    Object isClosed = freezed,
    Object isMember = freezed,
    Object homeTokenAddress = freezed,
    Object metadata = freezed,
    Object webUrl = freezed,
    Object bridgeType = freezed,
    Object bridgeDirection = freezed,
    Object homeBridgeAddress = freezed,
    Object foreignBridgeAddress = freezed,
    Object foreignTokenAddress = freezed,
    Object plugins = freezed,
    Object businesses = freezed,
    Object description = freezed,
  }) {
    return _then(_Community(
      name: name == freezed ? _value.name : name as String,
      address: address == freezed ? _value.address : address as String,
      isMultiBridge: isMultiBridge == freezed
          ? _value.isMultiBridge
          : isMultiBridge as bool,
      isClosed: isClosed == freezed ? _value.isClosed : isClosed as bool,
      isMember: isMember == freezed ? _value.isMember : isMember as bool,
      homeTokenAddress: homeTokenAddress == freezed
          ? _value.homeTokenAddress
          : homeTokenAddress as String,
      metadata:
          metadata == freezed ? _value.metadata : metadata as CommunityMetadata,
      webUrl: webUrl == freezed ? _value.webUrl : webUrl as String,
      bridgeType:
          bridgeType == freezed ? _value.bridgeType : bridgeType as String,
      bridgeDirection: bridgeDirection == freezed
          ? _value.bridgeDirection
          : bridgeDirection as String,
      homeBridgeAddress: homeBridgeAddress == freezed
          ? _value.homeBridgeAddress
          : homeBridgeAddress as String,
      foreignBridgeAddress: foreignBridgeAddress == freezed
          ? _value.foreignBridgeAddress
          : foreignBridgeAddress as String,
      foreignTokenAddress: foreignTokenAddress == freezed
          ? _value.foreignTokenAddress
          : foreignTokenAddress as String,
      plugins: plugins == freezed ? _value.plugins : plugins as Plugins,
      businesses: businesses == freezed
          ? _value.businesses
          : businesses as List<Business>,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Community implements _Community {
  _$_Community(
      {this.name,
      this.address,
      this.isMultiBridge = false,
      this.isClosed = false,
      this.isMember = false,
      @nullable
          this.homeTokenAddress,
      @nullable
          this.metadata,
      @nullable
          this.webUrl,
      @JsonKey(includeIfNull: false)
      @nullable
          this.bridgeType,
      @JsonKey(includeIfNull: false)
      @nullable
          this.bridgeDirection,
      @JsonKey(includeIfNull: false)
      @nullable
          this.homeBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          this.foreignBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          this.foreignTokenAddress,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
          this.plugins,
      @nullable
      @JsonKey(includeIfNull: false)
          this.businesses = const [],
      @nullable
          this.description})
      : assert(isMultiBridge != null),
        assert(isClosed != null),
        assert(isMember != null);

  factory _$_Community.fromJson(Map<String, dynamic> json) =>
      _$_$_CommunityFromJson(json);

  @override
  final String name;
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
  @nullable
  final String homeTokenAddress;
  @override
  @nullable
  final CommunityMetadata metadata;
  @override
  @nullable
  final String webUrl;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  final String bridgeType;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  final String bridgeDirection;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  final String homeBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  final String foreignBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  final String foreignTokenAddress;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
  final Plugins plugins;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  final List<Business> businesses;
  @override
  @nullable
  final String description;

  @override
  String toString() {
    return 'Community(name: $name, address: $address, isMultiBridge: $isMultiBridge, isClosed: $isClosed, isMember: $isMember, homeTokenAddress: $homeTokenAddress, metadata: $metadata, webUrl: $webUrl, bridgeType: $bridgeType, bridgeDirection: $bridgeDirection, homeBridgeAddress: $homeBridgeAddress, foreignBridgeAddress: $foreignBridgeAddress, foreignTokenAddress: $foreignTokenAddress, plugins: $plugins, businesses: $businesses, description: $description)';
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
      @nullable
          String homeTokenAddress,
      @nullable
          CommunityMetadata metadata,
      @nullable
          String webUrl,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeType,
      @JsonKey(includeIfNull: false)
      @nullable
          String bridgeDirection,
      @JsonKey(includeIfNull: false)
      @nullable
          String homeBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignBridgeAddress,
      @JsonKey(includeIfNull: false)
      @nullable
          String foreignTokenAddress,
      @nullable
      @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
          Plugins plugins,
      @nullable
      @JsonKey(includeIfNull: false)
          List<Business> businesses,
      @nullable
          String description}) = _$_Community;

  factory _Community.fromJson(Map<String, dynamic> json) =
      _$_Community.fromJson;

  @override
  String get name;
  @override
  String get address;
  @override
  bool get isMultiBridge;
  @override
  bool get isClosed;
  @override
  bool get isMember;
  @override
  @nullable
  String get homeTokenAddress;
  @override
  @nullable
  CommunityMetadata get metadata;
  @override
  @nullable
  String get webUrl;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  String get bridgeType;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  String get bridgeDirection;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  String get homeBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  String get foreignBridgeAddress;
  @override
  @JsonKey(includeIfNull: false)
  @nullable
  String get foreignTokenAddress;
  @override
  @nullable
  @JsonKey(includeIfNull: false, fromJson: pluginsFromJson)
  Plugins get plugins;
  @override
  @nullable
  @JsonKey(includeIfNull: false)
  List<Business> get businesses;
  @override
  @nullable
  String get description;
  @override
  @JsonKey(ignore: true)
  _$CommunityCopyWith<_Community> get copyWith;
}

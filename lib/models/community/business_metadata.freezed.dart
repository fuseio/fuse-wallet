// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'business_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BusinessMetadata _$BusinessMetadataFromJson(Map<String, dynamic> json) {
  return _BusinessMetadata.fromJson(json);
}

/// @nodoc
class _$BusinessMetadataTearOff {
  const _$BusinessMetadataTearOff();

// ignore: unused_element
  _BusinessMetadata call(
      {String address = '',
      String description = '',
      String image = '',
      String coverPhoto = '',
      String type = '',
      String phoneNumber = '',
      String website = '',
      List<double> latLng = const []}) {
    return _BusinessMetadata(
      address: address,
      description: description,
      image: image,
      coverPhoto: coverPhoto,
      type: type,
      phoneNumber: phoneNumber,
      website: website,
      latLng: latLng,
    );
  }

// ignore: unused_element
  BusinessMetadata fromJson(Map<String, Object> json) {
    return BusinessMetadata.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $BusinessMetadata = _$BusinessMetadataTearOff();

/// @nodoc
mixin _$BusinessMetadata {
  String get address;
  String get description;
  String get image;
  String get coverPhoto;
  String get type;
  String get phoneNumber;
  String get website;
  List<double> get latLng;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $BusinessMetadataCopyWith<BusinessMetadata> get copyWith;
}

/// @nodoc
abstract class $BusinessMetadataCopyWith<$Res> {
  factory $BusinessMetadataCopyWith(
          BusinessMetadata value, $Res Function(BusinessMetadata) then) =
      _$BusinessMetadataCopyWithImpl<$Res>;
  $Res call(
      {String address,
      String description,
      String image,
      String coverPhoto,
      String type,
      String phoneNumber,
      String website,
      List<double> latLng});
}

/// @nodoc
class _$BusinessMetadataCopyWithImpl<$Res>
    implements $BusinessMetadataCopyWith<$Res> {
  _$BusinessMetadataCopyWithImpl(this._value, this._then);

  final BusinessMetadata _value;
  // ignore: unused_field
  final $Res Function(BusinessMetadata) _then;

  @override
  $Res call({
    Object address = freezed,
    Object description = freezed,
    Object image = freezed,
    Object coverPhoto = freezed,
    Object type = freezed,
    Object phoneNumber = freezed,
    Object website = freezed,
    Object latLng = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed ? _value.address : address as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      coverPhoto:
          coverPhoto == freezed ? _value.coverPhoto : coverPhoto as String,
      type: type == freezed ? _value.type : type as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      website: website == freezed ? _value.website : website as String,
      latLng: latLng == freezed ? _value.latLng : latLng as List<double>,
    ));
  }
}

/// @nodoc
abstract class _$BusinessMetadataCopyWith<$Res>
    implements $BusinessMetadataCopyWith<$Res> {
  factory _$BusinessMetadataCopyWith(
          _BusinessMetadata value, $Res Function(_BusinessMetadata) then) =
      __$BusinessMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String address,
      String description,
      String image,
      String coverPhoto,
      String type,
      String phoneNumber,
      String website,
      List<double> latLng});
}

/// @nodoc
class __$BusinessMetadataCopyWithImpl<$Res>
    extends _$BusinessMetadataCopyWithImpl<$Res>
    implements _$BusinessMetadataCopyWith<$Res> {
  __$BusinessMetadataCopyWithImpl(
      _BusinessMetadata _value, $Res Function(_BusinessMetadata) _then)
      : super(_value, (v) => _then(v as _BusinessMetadata));

  @override
  _BusinessMetadata get _value => super._value as _BusinessMetadata;

  @override
  $Res call({
    Object address = freezed,
    Object description = freezed,
    Object image = freezed,
    Object coverPhoto = freezed,
    Object type = freezed,
    Object phoneNumber = freezed,
    Object website = freezed,
    Object latLng = freezed,
  }) {
    return _then(_BusinessMetadata(
      address: address == freezed ? _value.address : address as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      coverPhoto:
          coverPhoto == freezed ? _value.coverPhoto : coverPhoto as String,
      type: type == freezed ? _value.type : type as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      website: website == freezed ? _value.website : website as String,
      latLng: latLng == freezed ? _value.latLng : latLng as List<double>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BusinessMetadata implements _BusinessMetadata {
  _$_BusinessMetadata(
      {this.address = '',
      this.description = '',
      this.image = '',
      this.coverPhoto = '',
      this.type = '',
      this.phoneNumber = '',
      this.website = '',
      this.latLng = const []})
      : assert(address != null),
        assert(description != null),
        assert(image != null),
        assert(coverPhoto != null),
        assert(type != null),
        assert(phoneNumber != null),
        assert(website != null),
        assert(latLng != null);

  factory _$_BusinessMetadata.fromJson(Map<String, dynamic> json) =>
      _$_$_BusinessMetadataFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String address;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @JsonKey(defaultValue: '')
  @override
  final String image;
  @JsonKey(defaultValue: '')
  @override
  final String coverPhoto;
  @JsonKey(defaultValue: '')
  @override
  final String type;
  @JsonKey(defaultValue: '')
  @override
  final String phoneNumber;
  @JsonKey(defaultValue: '')
  @override
  final String website;
  @JsonKey(defaultValue: const [])
  @override
  final List<double> latLng;

  @override
  String toString() {
    return 'BusinessMetadata(address: $address, description: $description, image: $image, coverPhoto: $coverPhoto, type: $type, phoneNumber: $phoneNumber, website: $website, latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessMetadata &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.coverPhoto, coverPhoto) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhoto, coverPhoto)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.website, website) ||
                const DeepCollectionEquality()
                    .equals(other.website, website)) &&
            (identical(other.latLng, latLng) ||
                const DeepCollectionEquality().equals(other.latLng, latLng)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(coverPhoto) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(website) ^
      const DeepCollectionEquality().hash(latLng);

  @JsonKey(ignore: true)
  @override
  _$BusinessMetadataCopyWith<_BusinessMetadata> get copyWith =>
      __$BusinessMetadataCopyWithImpl<_BusinessMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusinessMetadataToJson(this);
  }
}

abstract class _BusinessMetadata implements BusinessMetadata {
  factory _BusinessMetadata(
      {String address,
      String description,
      String image,
      String coverPhoto,
      String type,
      String phoneNumber,
      String website,
      List<double> latLng}) = _$_BusinessMetadata;

  factory _BusinessMetadata.fromJson(Map<String, dynamic> json) =
      _$_BusinessMetadata.fromJson;

  @override
  String get address;
  @override
  String get description;
  @override
  String get image;
  @override
  String get coverPhoto;
  @override
  String get type;
  @override
  String get phoneNumber;
  @override
  String get website;
  @override
  List<double> get latLng;
  @override
  @JsonKey(ignore: true)
  _$BusinessMetadataCopyWith<_BusinessMetadata> get copyWith;
}

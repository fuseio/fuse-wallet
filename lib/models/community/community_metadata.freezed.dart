// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'community_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) {
  return _CommunityMetadata.fromJson(json);
}

/// @nodoc
class _$CommunityMetadataTearOff {
  const _$CommunityMetadataTearOff();

// ignore: unused_element
  _CommunityMetadata call(
      {bool isDefaultImage,
      String image,
      String coverPhoto,
      String coverPhotoUri,
      String imageUri}) {
    return _CommunityMetadata(
      isDefaultImage: isDefaultImage,
      image: image,
      coverPhoto: coverPhoto,
      coverPhotoUri: coverPhotoUri,
      imageUri: imageUri,
    );
  }

// ignore: unused_element
  CommunityMetadata fromJson(Map<String, Object> json) {
    return CommunityMetadata.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CommunityMetadata = _$CommunityMetadataTearOff();

/// @nodoc
mixin _$CommunityMetadata {
  bool get isDefaultImage;
  String get image;
  String get coverPhoto;
  String get coverPhotoUri;
  String get imageUri;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CommunityMetadataCopyWith<CommunityMetadata> get copyWith;
}

/// @nodoc
abstract class $CommunityMetadataCopyWith<$Res> {
  factory $CommunityMetadataCopyWith(
          CommunityMetadata value, $Res Function(CommunityMetadata) then) =
      _$CommunityMetadataCopyWithImpl<$Res>;
  $Res call(
      {bool isDefaultImage,
      String image,
      String coverPhoto,
      String coverPhotoUri,
      String imageUri});
}

/// @nodoc
class _$CommunityMetadataCopyWithImpl<$Res>
    implements $CommunityMetadataCopyWith<$Res> {
  _$CommunityMetadataCopyWithImpl(this._value, this._then);

  final CommunityMetadata _value;
  // ignore: unused_field
  final $Res Function(CommunityMetadata) _then;

  @override
  $Res call({
    Object isDefaultImage = freezed,
    Object image = freezed,
    Object coverPhoto = freezed,
    Object coverPhotoUri = freezed,
    Object imageUri = freezed,
  }) {
    return _then(_value.copyWith(
      isDefaultImage: isDefaultImage == freezed
          ? _value.isDefaultImage
          : isDefaultImage as bool,
      image: image == freezed ? _value.image : image as String,
      coverPhoto:
          coverPhoto == freezed ? _value.coverPhoto : coverPhoto as String,
      coverPhotoUri: coverPhotoUri == freezed
          ? _value.coverPhotoUri
          : coverPhotoUri as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
    ));
  }
}

/// @nodoc
abstract class _$CommunityMetadataCopyWith<$Res>
    implements $CommunityMetadataCopyWith<$Res> {
  factory _$CommunityMetadataCopyWith(
          _CommunityMetadata value, $Res Function(_CommunityMetadata) then) =
      __$CommunityMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isDefaultImage,
      String image,
      String coverPhoto,
      String coverPhotoUri,
      String imageUri});
}

/// @nodoc
class __$CommunityMetadataCopyWithImpl<$Res>
    extends _$CommunityMetadataCopyWithImpl<$Res>
    implements _$CommunityMetadataCopyWith<$Res> {
  __$CommunityMetadataCopyWithImpl(
      _CommunityMetadata _value, $Res Function(_CommunityMetadata) _then)
      : super(_value, (v) => _then(v as _CommunityMetadata));

  @override
  _CommunityMetadata get _value => super._value as _CommunityMetadata;

  @override
  $Res call({
    Object isDefaultImage = freezed,
    Object image = freezed,
    Object coverPhoto = freezed,
    Object coverPhotoUri = freezed,
    Object imageUri = freezed,
  }) {
    return _then(_CommunityMetadata(
      isDefaultImage: isDefaultImage == freezed
          ? _value.isDefaultImage
          : isDefaultImage as bool,
      image: image == freezed ? _value.image : image as String,
      coverPhoto:
          coverPhoto == freezed ? _value.coverPhoto : coverPhoto as String,
      coverPhotoUri: coverPhotoUri == freezed
          ? _value.coverPhotoUri
          : coverPhotoUri as String,
      imageUri: imageUri == freezed ? _value.imageUri : imageUri as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CommunityMetadata extends _CommunityMetadata {
  _$_CommunityMetadata(
      {this.isDefaultImage,
      this.image,
      this.coverPhoto,
      this.coverPhotoUri,
      this.imageUri})
      : super._();

  factory _$_CommunityMetadata.fromJson(Map<String, dynamic> json) =>
      _$_$_CommunityMetadataFromJson(json);

  @override
  final bool isDefaultImage;
  @override
  final String image;
  @override
  final String coverPhoto;
  @override
  final String coverPhotoUri;
  @override
  final String imageUri;

  @override
  String toString() {
    return 'CommunityMetadata(isDefaultImage: $isDefaultImage, image: $image, coverPhoto: $coverPhoto, coverPhotoUri: $coverPhotoUri, imageUri: $imageUri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommunityMetadata &&
            (identical(other.isDefaultImage, isDefaultImage) ||
                const DeepCollectionEquality()
                    .equals(other.isDefaultImage, isDefaultImage)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.coverPhoto, coverPhoto) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhoto, coverPhoto)) &&
            (identical(other.coverPhotoUri, coverPhotoUri) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhotoUri, coverPhotoUri)) &&
            (identical(other.imageUri, imageUri) ||
                const DeepCollectionEquality()
                    .equals(other.imageUri, imageUri)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isDefaultImage) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(coverPhoto) ^
      const DeepCollectionEquality().hash(coverPhotoUri) ^
      const DeepCollectionEquality().hash(imageUri);

  @JsonKey(ignore: true)
  @override
  _$CommunityMetadataCopyWith<_CommunityMetadata> get copyWith =>
      __$CommunityMetadataCopyWithImpl<_CommunityMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CommunityMetadataToJson(this);
  }
}

abstract class _CommunityMetadata extends CommunityMetadata {
  _CommunityMetadata._() : super._();
  factory _CommunityMetadata(
      {bool isDefaultImage,
      String image,
      String coverPhoto,
      String coverPhotoUri,
      String imageUri}) = _$_CommunityMetadata;

  factory _CommunityMetadata.fromJson(Map<String, dynamic> json) =
      _$_CommunityMetadata.fromJson;

  @override
  bool get isDefaultImage;
  @override
  String get image;
  @override
  String get coverPhoto;
  @override
  String get coverPhotoUri;
  @override
  String get imageUri;
  @override
  @JsonKey(ignore: true)
  _$CommunityMetadataCopyWith<_CommunityMetadata> get copyWith;
}

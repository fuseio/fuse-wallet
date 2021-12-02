// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'community_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) {
  return _CommunityMetadata.fromJson(json);
}

/// @nodoc
class _$CommunityMetadataTearOff {
  const _$CommunityMetadataTearOff();

  _CommunityMetadata call(
      {bool isDefaultImage = false,
      String image = '',
      String coverPhoto = '',
      String coverPhotoUri = '',
      String imageUri = ''}) {
    return _CommunityMetadata(
      isDefaultImage: isDefaultImage,
      image: image,
      coverPhoto: coverPhoto,
      coverPhotoUri: coverPhotoUri,
      imageUri: imageUri,
    );
  }

  CommunityMetadata fromJson(Map<String, Object?> json) {
    return CommunityMetadata.fromJson(json);
  }
}

/// @nodoc
const $CommunityMetadata = _$CommunityMetadataTearOff();

/// @nodoc
mixin _$CommunityMetadata {
  bool get isDefaultImage => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get coverPhoto => throw _privateConstructorUsedError;
  String get coverPhotoUri => throw _privateConstructorUsedError;
  String get imageUri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommunityMetadataCopyWith<CommunityMetadata> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? isDefaultImage = freezed,
    Object? image = freezed,
    Object? coverPhoto = freezed,
    Object? coverPhotoUri = freezed,
    Object? imageUri = freezed,
  }) {
    return _then(_value.copyWith(
      isDefaultImage: isDefaultImage == freezed
          ? _value.isDefaultImage
          : isDefaultImage // ignore: cast_nullable_to_non_nullable
              as bool,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      coverPhoto: coverPhoto == freezed
          ? _value.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String,
      coverPhotoUri: coverPhotoUri == freezed
          ? _value.coverPhotoUri
          : coverPhotoUri // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: imageUri == freezed
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String,
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
    Object? isDefaultImage = freezed,
    Object? image = freezed,
    Object? coverPhoto = freezed,
    Object? coverPhotoUri = freezed,
    Object? imageUri = freezed,
  }) {
    return _then(_CommunityMetadata(
      isDefaultImage: isDefaultImage == freezed
          ? _value.isDefaultImage
          : isDefaultImage // ignore: cast_nullable_to_non_nullable
              as bool,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      coverPhoto: coverPhoto == freezed
          ? _value.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String,
      coverPhotoUri: coverPhotoUri == freezed
          ? _value.coverPhotoUri
          : coverPhotoUri // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: imageUri == freezed
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_CommunityMetadata extends _CommunityMetadata
    with DiagnosticableTreeMixin {
  _$_CommunityMetadata(
      {this.isDefaultImage = false,
      this.image = '',
      this.coverPhoto = '',
      this.coverPhotoUri = '',
      this.imageUri = ''})
      : super._();

  factory _$_CommunityMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_CommunityMetadataFromJson(json);

  @JsonKey(defaultValue: false)
  @override
  final bool isDefaultImage;
  @JsonKey(defaultValue: '')
  @override
  final String image;
  @JsonKey(defaultValue: '')
  @override
  final String coverPhoto;
  @JsonKey(defaultValue: '')
  @override
  final String coverPhotoUri;
  @JsonKey(defaultValue: '')
  @override
  final String imageUri;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommunityMetadata(isDefaultImage: $isDefaultImage, image: $image, coverPhoto: $coverPhoto, coverPhotoUri: $coverPhotoUri, imageUri: $imageUri)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommunityMetadata'))
      ..add(DiagnosticsProperty('isDefaultImage', isDefaultImage))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('coverPhoto', coverPhoto))
      ..add(DiagnosticsProperty('coverPhotoUri', coverPhotoUri))
      ..add(DiagnosticsProperty('imageUri', imageUri));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommunityMetadata &&
            (identical(other.isDefaultImage, isDefaultImage) ||
                other.isDefaultImage == isDefaultImage) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.coverPhoto, coverPhoto) ||
                other.coverPhoto == coverPhoto) &&
            (identical(other.coverPhotoUri, coverPhotoUri) ||
                other.coverPhotoUri == coverPhotoUri) &&
            (identical(other.imageUri, imageUri) ||
                other.imageUri == imageUri));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isDefaultImage, image, coverPhoto, coverPhotoUri, imageUri);

  @JsonKey(ignore: true)
  @override
  _$CommunityMetadataCopyWith<_CommunityMetadata> get copyWith =>
      __$CommunityMetadataCopyWithImpl<_CommunityMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommunityMetadataToJson(this);
  }
}

abstract class _CommunityMetadata extends CommunityMetadata {
  factory _CommunityMetadata(
      {bool isDefaultImage,
      String image,
      String coverPhoto,
      String coverPhotoUri,
      String imageUri}) = _$_CommunityMetadata;
  _CommunityMetadata._() : super._();

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
  _$CommunityMetadataCopyWith<_CommunityMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

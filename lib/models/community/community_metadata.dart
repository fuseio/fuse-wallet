import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/utils/images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.freezed.dart';
part 'community_metadata.g.dart';

@immutable
@freezed
class CommunityMetadata with _$CommunityMetadata {
  @JsonSerializable()
  factory CommunityMetadata({
    @Default(false) bool isDefaultImage,
    @Default('') String image,
    @Default('') String coverPhoto,
    @Default('') String coverPhotoUri,
    @Default('') String imageUri,
  }) = _CommunityMetadata;

  const CommunityMetadata._();

  String getImageUri() {
    if (![null, ''].contains(imageUri)) {
      return imageUri;
    } else {
      return ImageUrl.getLink(image);
    }
  }

  String getCoverPhotoUri() {
    if (![null, ''].contains(coverPhotoUri)) {
      return coverPhotoUri;
    } else {
      return ImageUrl.getLink(coverPhoto);
    }
  }

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommunityMetadataFromJson(json);
}

class CommunityMetadataConverter
    implements JsonConverter<CommunityMetadata?, Map<String, dynamic>?> {
  const CommunityMetadataConverter();

  @override
  CommunityMetadata? fromJson(Map<String, dynamic>? json) =>
      json != null ? CommunityMetadata.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(CommunityMetadata? instance) =>
      instance?.toJson();
}

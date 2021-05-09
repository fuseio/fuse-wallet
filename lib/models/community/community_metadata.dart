import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/utils/images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.freezed.dart';
part 'community_metadata.g.dart';

@immutable
@freezed
class CommunityMetadata with _$CommunityMetadata {
  @JsonSerializable()
  factory CommunityMetadata({
    @Default(false) bool isDefaultImage,
    @Default(null) String image,
    @Default(null) String coverPhoto,
    @Default(null) String coverPhotoUri,
    @Default(null) String imageUri,
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

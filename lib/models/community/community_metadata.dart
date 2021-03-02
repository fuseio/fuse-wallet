import 'package:peepl/utils/transaction_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  @JsonKey(defaultValue: '')
  final String image;
  @JsonKey(defaultValue: '')
  final String coverPhoto;
  @JsonKey(defaultValue: false)
  final bool isDefaultImage;
  @JsonKey(defaultValue: '')
  final String imageUri;
  @JsonKey(defaultValue: '')
  final String coverPhotoUri;

  CommunityMetadata({
    this.isDefaultImage,
    this.image,
    this.coverPhoto,
    this.coverPhotoUri,
    this.imageUri,
  });

  CommunityMetadata copyWith({
    bool isDefaultImage,
    String coverPhoto,
    String image,
    String coverPhotoUri,
    String imageUri,
  }) =>
      CommunityMetadata(
        image: image,
        imageUri: imageUri,
        coverPhoto: coverPhoto,
        coverPhotoUri: coverPhotoUri,
        isDefaultImage: isDefaultImage,
      );

  String getImageUri() {
    if (![null, ''].contains(imageUri)) {
      return imageUri;
    } else if (![null, ''].contains(image)) {
      return getIPFSImageUrl(image);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  String getCoverPhotoUri() {
    if (![null, ''].contains(coverPhotoUri)) {
      return coverPhotoUri;
    } else if (![null, ''].contains(coverPhoto)) {
      return getIPFSImageUrl(coverPhoto);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  factory CommunityMetadata.initial() => CommunityMetadata();

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);
}

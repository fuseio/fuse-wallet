import 'package:esol/utils/transaction_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  final String image;
  final String coverPhoto;
  final bool isDefaultImage;
  final String imageUri;
  final String coverPhotoUri;

  CommunityMetadata(
      {this.isDefaultImage = false,
      this.image = '',
      this.coverPhoto = '',
      this.coverPhotoUri = '',
      this.imageUri = ''});

  CommunityMetadata copyWith(
          {bool isDefaultImage,
          String coverPhoto,
          String image,
          String coverPhotoUri,
          String imageUri}) =>
      CommunityMetadata(
          image: image,
          imageUri: imageUri,
          coverPhoto: coverPhoto,
          coverPhotoUri: coverPhotoUri,
          isDefaultImage: isDefaultImage);

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

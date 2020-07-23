import 'package:digitalrand/utils/transaction_row.dart';
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
      this.coverPhotoUri,
      this.imageUri});

  String getImageUri() {
    print('imageUri imageUri $imageUri');
    if (imageUri != null && imageUri.isNotEmpty) {
      return imageUri;
    } else if (image != null && image.isNotEmpty) {
      return getIPFSImageUrl(image);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  String getCoverPhotoUri() {
    if (coverPhotoUri != null && coverPhotoUri.isNotEmpty) {
      return coverPhotoUri;
    } else if (coverPhoto != null && coverPhoto.isNotEmpty) {
      return getIPFSImageUrl(coverPhoto);
    }
    return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
  }

  factory CommunityMetadata.initial() =>
      new CommunityMetadata(image: '', coverPhoto: '');

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);
}

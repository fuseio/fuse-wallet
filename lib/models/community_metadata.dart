import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  final String image;
  final String coverPhoto;
  final bool isDefaultImage;

  CommunityMetadata({
    this.isDefaultImage = false,
    this.image = '',
    this.coverPhoto = '',
  });

  factory CommunityMetadata.initial() => new CommunityMetadata(
      image: '',
      coverPhoto: ''
    );

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) => _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);

}
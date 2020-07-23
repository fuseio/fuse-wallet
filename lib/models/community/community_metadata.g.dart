// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) {
  return CommunityMetadata(
    isDefaultImage: json['isDefaultImage'] as bool,
    image: json['image'] as String,
    coverPhoto: json['coverPhoto'] as String,
    coverPhotoUri: json['coverPhotoUri'] as String,
    imageUri: json['imageUri'] as String,
  );
}

Map<String, dynamic> _$CommunityMetadataToJson(CommunityMetadata instance) =>
    <String, dynamic>{
      'image': instance.image,
      'coverPhoto': instance.coverPhoto,
      'isDefaultImage': instance.isDefaultImage,
      'imageUri': instance.imageUri,
      'coverPhotoUri': instance.coverPhotoUri,
    };

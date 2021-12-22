// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommunityMetadata _$$_CommunityMetadataFromJson(Map<String, dynamic> json) =>
    _$_CommunityMetadata(
      isDefaultImage: json['isDefaultImage'] as bool? ?? false,
      image: json['image'] as String? ?? '',
      coverPhoto: json['coverPhoto'] as String? ?? '',
      coverPhotoUri: json['coverPhotoUri'] as String? ?? '',
      imageUri: json['imageUri'] as String? ?? '',
    );

Map<String, dynamic> _$$_CommunityMetadataToJson(
        _$_CommunityMetadata instance) =>
    <String, dynamic>{
      'isDefaultImage': instance.isDefaultImage,
      'image': instance.image,
      'coverPhoto': instance.coverPhoto,
      'coverPhotoUri': instance.coverPhotoUri,
      'imageUri': instance.imageUri,
    };

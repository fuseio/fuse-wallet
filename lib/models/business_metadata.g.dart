// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessMetadata _$BusinessMetadataFromJson(Map<String, dynamic> json) {
  return BusinessMetadata(
    address: json['address'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    coverPhoto: json['coverPhoto'] as String,
  );
}

Map<String, dynamic> _$BusinessMetadataToJson(BusinessMetadata instance) =>
    <String, dynamic>{
      'address': instance.address,
      'coverPhoto': instance.coverPhoto,
      'description': instance.description,
      'image': instance.image,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusinessMetadata _$_$_BusinessMetadataFromJson(Map<String, dynamic> json) {
  return _$_BusinessMetadata(
    address: json['address'] as String? ?? '',
    description: json['description'] as String? ?? '',
    image: json['image'] as String? ?? '',
    coverPhoto: json['coverPhoto'] as String? ?? '',
    type: json['type'] as String? ?? '',
    phoneNumber: json['phoneNumber'] as String? ?? '',
    website: json['website'] as String? ?? '',
    latLng: (json['latLng'] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_BusinessMetadataToJson(
        _$_BusinessMetadata instance) =>
    <String, dynamic>{
      'address': instance.address,
      'description': instance.description,
      'image': instance.image,
      'coverPhoto': instance.coverPhoto,
      'type': instance.type,
      'phoneNumber': instance.phoneNumber,
      'website': instance.website,
      'latLng': instance.latLng,
    };

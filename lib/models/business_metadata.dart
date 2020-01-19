import 'package:json_annotation/json_annotation.dart';

part 'business_metadata.g.dart';

@JsonSerializable()
class BusinessMetadata {
  final String address;
  final String coverPhoto;
  final String description;
  final String image;

  BusinessMetadata({
    this.address = '',
    this.description = '',
    this.image = '',
    this.coverPhoto = ''
  });

  factory BusinessMetadata.initial() => new BusinessMetadata(
      address: '',
      coverPhoto: '',
      description: '',
      image: ''
    );

  factory BusinessMetadata.fromJson(Map<String, dynamic> json) => _$BusinessMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessMetadataToJson(this);

}
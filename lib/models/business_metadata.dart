import 'package:json_annotation/json_annotation.dart';

part 'business_metadata.g.dart';

@JsonSerializable()
class BusinessMetadata {
  final String address;
  final String coverPhoto;
  final String description;
  final String image;
  final String type;
  final String phoneNumber;
  final String website;
  final List<double> latLng;

  BusinessMetadata({
    this.address = '',
    this.description = '',
    this.image = '',
    this.coverPhoto = '',
    this.type = '',
    this.phoneNumber = '',
    this.website = '',
    this.latLng
  });

  factory BusinessMetadata.initial() => new BusinessMetadata(
      address: '',
      coverPhoto: '',
      description: '',
      image: '',
      type: '',
      phoneNumber: '',
      website: '',
    );

  factory BusinessMetadata.fromJson(Map<String, dynamic> json) => _$BusinessMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessMetadataToJson(this);

}
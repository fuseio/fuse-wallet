import 'package:fusecash/utils/images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class BusinessMetadata {
  final String address;
  final String coverPhoto;
  final String description;
  final String image;
  final String type;
  final String phoneNumber;
  final String website;
  final List<double> latLng;

  String getImageUri() => ImageUrl.getLink(image);

  String getCoverPhotoUri() => ImageUrl.getLink(coverPhoto);

  BusinessMetadata(
      {this.address = '',
      this.description = '',
      this.image = '',
      this.coverPhoto = '',
      this.type = '',
      this.phoneNumber = '',
      this.website = '',
      this.latLng});

  BusinessMetadata copyWith({
    String address,
    String coverPhoto,
    String description,
    String image,
    String type,
    String phoneNumber,
    String website,
    List<double> latLng,
  }) {
    return BusinessMetadata(
      address: address ?? this.address,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      description: description ?? this.description,
      image: image ?? this.image,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      latLng: latLng ?? this.latLng,
    );
  }

  factory BusinessMetadata.initial() => new BusinessMetadata(
        address: '',
        coverPhoto: '',
        description: '',
        image: '',
        type: '',
        phoneNumber: '',
        website: '',
      );

  factory BusinessMetadata.fromJson(Map<String, dynamic> json) =>
      _$BusinessMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessMetadataToJson(this);
}

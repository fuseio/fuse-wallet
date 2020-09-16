import 'package:esol/utils/transaction_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_metadata.g.dart';

bool isIpfsHash(String hash) => hash != null && hash.length == 46;
bool isS3Hash(String hash) => hash != null && hash.length == 64;

String getImage(hash) {
  if (isIpfsHash(hash)) {
    return getIPFSImageUrl(hash);
  } else if (isS3Hash(hash)) {
    return getS3ImageUrl(hash);
  }
  return 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png';
}

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

  String getImageUri() => getImage(image);

  String getCoverPhotoUri() => getImage(coverPhoto);

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

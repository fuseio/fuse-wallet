import 'package:json_annotation/json_annotation.dart';

part 'business_metadata.g.dart';

@JsonSerializable()
class BusinessMetadata {
  final String address;
  final String coverPhoto;
  final String description;
  final String image;

  BusinessMetadata({
    this.address,
    this.description,
    this.image,
    this.coverPhoto
  });

  BusinessMetadata.fromJson(Map<String, dynamic> json)
      : description = json['description'] != null ? json['description'] : "",
        image = json['image'] != null
            ? "" +
                ("https://ipfs-proxy-qa.fuse.io/api/image/" +
                    json['image'])
            : 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
        coverPhoto = json['coverPhoto'] != null
            ? "" +
                ("https://ipfs-proxy-qa.fuse.io/api/image/" +
                    json['coverPhoto'])
            : 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
        address = json['address'] != null ? json['address'] : "";

  Map<String, dynamic> toJson() =>
    {
      'description': description,
      'image': image,
      'coverPhoto': coverPhoto,
      'address': address
    };
}

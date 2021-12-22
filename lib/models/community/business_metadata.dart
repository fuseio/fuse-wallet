import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'business_metadata.freezed.dart';
part 'business_metadata.g.dart';

@immutable
@freezed
class BusinessMetadata with _$BusinessMetadata {
  @JsonSerializable()
  factory BusinessMetadata({
    @Default('') String address,
    @Default('') String description,
    @Default('') String image,
    @Default('') String coverPhoto,
    @Default('') String type,
    @Default('') String phoneNumber,
    @Default('') String website,
    @Default([]) List<double> latLng,
  }) = _BusinessMetadata;

  factory BusinessMetadata.fromJson(Map<String, dynamic> json) =>
      _$BusinessMetadataFromJson(json);
}

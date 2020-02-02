import 'package:paywise/models/business_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable()
class Business {
  final String account;
  final String id;
  final String name;
  @JsonKey(
      name: 'metadata',
      fromJson: _businessMetadataFromJson,
      toJson: _businessMetadataToJson)
  final BusinessMetadata metadata;

  Business({
    this.account = '',
    this.id = '',
    this.metadata,
    this.name = '',
  });

  static BusinessMetadata _businessMetadataFromJson(
          Map<String, dynamic> json) =>
      json == null
          ? BusinessMetadata.initial()
          : BusinessMetadata.fromJson(json);

  static Map<String, dynamic> _businessMetadataToJson(
          BusinessMetadata metadata) =>
      metadata.toJson();

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}

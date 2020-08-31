import 'package:esol/models/community/business_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable(explicitToJson: true)
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

  Business copyWith({
    BusinessMetadata metadata,
    String account,
    String name,
    String id,
  }) {
    return Business(
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      name: name ?? this.name,
      account: account ?? this.account,
    );
  }

  factory Business.initial() {
    return new Business(
        account: '', metadata: BusinessMetadata.initial(), name: '', id: '');
  }

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

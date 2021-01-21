import 'package:equatable/equatable.dart';
import 'package:supervecina/models/community/business_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable(explicitToJson: true)
class Business extends Equatable {
  final String account;
  final String id;
  final int area;
  final String name;
  @JsonKey(
      name: 'metadata',
      fromJson: _businessMetadataFromJson,
      toJson: _businessMetadataToJson)
  final BusinessMetadata metadata;

  @override
  List get props => [metadata, account, area];

  Business({
    this.account = '',
    this.id = '',
    this.metadata,
    this.name = '',
    this.area,
  });

  Business copyWith({
    BusinessMetadata metadata,
    String account,
    String name,
    String id,
    String area,
  }) {
    return Business(
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      name: name ?? this.name,
      account: account ?? this.account,
      area: area ?? this.area,
    );
  }

  factory Business.initial() {
    return new Business(
      account: '',
      metadata: BusinessMetadata.initial(),
      name: '',
      id: '',
      area: 0,
    );
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

import 'package:fusecash/models/business_metadata.dart';

class Business {
  final String account;
  final String id;
  final String name;
  final BusinessMetadata metadata;

  Business({
    this.account,
    this.metadata,
    this.id,
    this.name,
  });

  Business.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        account = json['account'],
        metadata = BusinessMetadata.fromJson(json['metadata']),
        name = json['name'] ?? "";

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'account': account,
      'metadata': metadata,
      'name': name
    };
}

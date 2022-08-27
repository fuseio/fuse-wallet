import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_credential_options.g.dart';

@JsonSerializable()
class IssueCredentialOptions {
  final String proofPurpose;
  final String verificationMethod;

  const IssueCredentialOptions({
    required this.proofPurpose,
    required this.verificationMethod,
  });

  Map<String, dynamic> toJson() => _$IssueCredentialOptionsToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/verifiable_credential/user_info_credential_subject.dart';

part 'self_issued_credential.g.dart';

@JsonSerializable(explicitToJson: true)
class SelfIssuedCredential {
  final String id;
  final String issuer;
  final String issuanceDate;
  final UserInfoCredentialSubject userInfoCredentialSubject;

  const SelfIssuedCredential({
    required this.id,
    required this.issuer,
    required this.issuanceDate,
    required this.userInfoCredentialSubject,
  });

  factory SelfIssuedCredential.fromJson(Map<String, dynamic> json) =>
      _$SelfIssuedCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$SelfIssuedCredentialToJson(this);
}

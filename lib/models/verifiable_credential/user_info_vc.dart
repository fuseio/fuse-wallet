import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/verifiable_credential/user_info_credential_subject.dart';

part 'self_issued_credential.g.dart';

@JsonSerializable()
class UserInfoVC {
  @JsonKey(name: "@context", defaultValue: _context)
  final List<dynamic> context;

  final String id;

  @JsonKey(defaultValue: _type)
  final List<String> type;

  final String issuer;
  final String issuanceDate;

  @JsonKey(name: "credentialSubject")
  final UserInfoCredentialSubject userInfoCredentialSubject;

  const UserInfoVC({
    this.context = _context,
    required this.id,
    this.type = _type,
    required this.issuer,
    required this.issuanceDate,
    required this.userInfoCredentialSubject,
  });

  factory UserInfoVC.fromJson(Map<String, dynamic> json) =>
      _$SelfIssuedCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$SelfIssuedCredentialToJson(this);

  static const _context = <dynamic>[
    "https://www.w3.org/2018/credentials/v1",
    {
      'name': 'https://schema.org/name',
      'description': 'https://schema.org/description',
      'SelfIssued': {
        '@context': {
          '@protected': true,
          '@version': 1.1,
          'id': '@id',
          'schema': 'https://schema.org/',
          'telephone': 'schema:telephone',
          'type': '@type'
        },
        // TODO: Create a README file for Fuse
        // TODO: and use it instead of the one below.
        '@id': 'https://github.com/TalaoDAO/context/blob/main/README.md'
      }
    },
  ];

  static const _type = <String>["VerifiableCredential", "SelfIssued"];
}

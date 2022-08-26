import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_credential_options.g.dart';

@JsonSerializable()
class VerifyCredentialOptions {
  final String proofPurpose;

  const VerifyCredentialOptions({required this.proofPurpose});

  Map<String, dynamic> toJson() => _$VerifyCredentialOptionsToJson(this);
}

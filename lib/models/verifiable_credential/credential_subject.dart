import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_subject.g.dart';

@JsonSerializable()
class CredentialSubject {
  final String id;
  final String type;

  const CredentialSubject({required this.id, required this.type});

  factory CredentialSubject.fromJson(Map<String, dynamic> json) =>
      _$CredentialSubjectFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}

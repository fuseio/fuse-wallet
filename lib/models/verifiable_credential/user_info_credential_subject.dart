import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/verifiable_credential/credential_subject.dart';

part 'user_info_credential_subject.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfoCredentialSubject extends CredentialSubject {
  final String name, phoneNumber;

  const UserInfoCredentialSubject({
    required String id,
    required this.name,
    required this.phoneNumber,
  }) : super(id: id);

  factory UserInfoCredentialSubject.fromJson(Map<String, dynamic> json) =>
      _$UserInfoCredentialSubjectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoCredentialSubjectToJson(this);
}

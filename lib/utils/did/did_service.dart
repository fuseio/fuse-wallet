import 'dart:convert';

import 'package:didkit/didkit.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/models/verifiable_credential/issue_credential_options.dart';
import 'package:fusecash/models/verifiable_credential/user_info_credential.dart';
import 'package:fusecash/models/verifiable_credential/user_info_credential_subject.dart';
import 'package:fusecash/models/verifiable_credential/verify_credential_options.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DIDService {
  final String privateKey;

  const DIDService({required this.privateKey});

  String generateDID() {
    return DIDKit.keyToDID(Strings.defaultDIDMethod, privateKey);
  }

  String issueUserInfoCredential({
    required String did,
    required String name,
    required String phoneNumber,
  }) {
    final userInfoCredentialModel =
        _createUserInfoCredentialModel(did, name, phoneNumber);
    final userInfoCredentialAsJson = jsonEncode(userInfoCredentialModel);

    final options = _createIssueCredentialOptions();
    final optionsAsJson = jsonEncode(options);

    return DIDKit.issueCredential(
      userInfoCredentialAsJson,
      optionsAsJson,
      privateKey,
    );
  }

  String verifyCredential(String credential) {
    final optionsAsJson = _createOptionsAsJson();
    return DIDKit.verifyCredential(credential, optionsAsJson);
  }

  String _createOptionsAsJson() {
    const options = VerifyCredentialOptions(proofPurpose: "assertionMethod");
    return jsonEncode(options);
  }

  IssueCredentialOptions _createIssueCredentialOptions() {
    final verificationMethod = _getVerificationMethod();
    return IssueCredentialOptions(
      proofPurpose: "assertionMethod",
      verificationMethod: verificationMethod,
    );
  }

  String _getVerificationMethod() {
    return DIDKit.keyToVerificationMethod(Strings.defaultDIDMethod, privateKey);
  }

  UserInfoCredential _createUserInfoCredentialModel(
    String did,
    String name,
    String phoneNumber,
  ) {
    final id = _createCredentialID();
    final issuanceDate = _createIssuanceDate();

    final userInfoCredentialSubject = UserInfoCredentialSubject(
      id: did,
      name: name,
      phoneNumber: phoneNumber,
    );

    return UserInfoCredential(
      id: id,
      issuer: did,
      issuanceDate: issuanceDate,
      userInfoCredentialSubject: userInfoCredentialSubject,
    );
  }

  String _createCredentialID() {
    final uuid = const Uuid().v4();
    return "urn:uuid:$uuid";
  }

  String _createIssuanceDate() {
    final dateFormatter = DateFormat("yyyy-MM-ddTHH:mm:ss");
    final now = DateTime.now();
    return "${dateFormatter.format(now)}Z";
  }
}

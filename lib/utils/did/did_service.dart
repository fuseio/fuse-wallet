import 'dart:convert';

import 'package:didkit/didkit.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/models/verifiable_credential/issue_credential_options.dart';
import 'package:fusecash/models/verifiable_credential/user_info_vc.dart';
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

  String issueUserInfoVC({
    required String did,
    required String name,
    required String phoneNumber,
  }) {
    final userInfoVCModel = _createUserInfoVCModel(did, name, phoneNumber);
    final userInfoVCAsJson = jsonEncode(userInfoVCModel);

    final options = _createIssueCredentialOptions();
    final optionsAsJson = jsonEncode(options);

    return DIDKit.issueCredential(userInfoVCAsJson, optionsAsJson, privateKey);
  }

  String verifyVC(String credential) {
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

  UserInfoVC _createUserInfoVCModel(
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

    return UserInfoVC(
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

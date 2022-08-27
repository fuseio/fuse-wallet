import 'package:flutter/widgets.dart';

class VerifyCredentialPageModel {
  final String privateKeyForDID;

  VerifyCredentialPageModel({required this.privateKeyForDID});

  final credentialTextController = TextEditingController();
}

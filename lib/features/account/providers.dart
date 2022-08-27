import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusecash/features/account/widget_models/verify_credential_page_model.dart';

final verifyCredentialPageModelProvider = Provider(
  (_) => VerifyCredentialPageModel(privateKeyForDID: ""),
);

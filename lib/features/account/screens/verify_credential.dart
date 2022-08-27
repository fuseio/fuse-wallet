import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusecash/features/account/providers.dart';
import 'package:fusecash/features/account/widget_models/verify_credential_page_model.dart';
import 'package:fusecash/features/account/widgets/credential_text_field.dart';
import 'package:fusecash/features/account/widgets/verify_credential_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';

class VerifyCredentialPage extends StatelessWidget {
  final String privateKeyForDID;

  const VerifyCredentialPage({
    Key? key,
    required this.privateKeyForDID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        verifyCredentialPageModelProvider.overrideWithValue(
          VerifyCredentialPageModel(privateKeyForDID: privateKeyForDID),
        ),
      ],
      child: InnerScaffold(
        title: "Verify Credential",
        padding: const EdgeInsets.symmetric(horizontal: 24),
        body: ListView(
          children: const [
            CredentialTextField(),
            SizedBox(height: 60),
            VerifyCredentialButton(),
          ],
        ),
      ),
    );
  }
}

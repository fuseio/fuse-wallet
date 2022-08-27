import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fusecash/features/account/providers.dart';

class CredentialTextField extends ConsumerWidget {
  const CredentialTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyCredentialPageModel =
        ref.watch(verifyCredentialPageModelProvider);
    final textController = verifyCredentialPageModel.credentialTextController;
    return TextField(
      controller: textController,
      decoration: const InputDecoration(
        hintText: "Insert the Verifiable Credential in JSON format here",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      maxLines: 10,
    );
  }
}

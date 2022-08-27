import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';

class VerifyCredentialMenuTile extends StatelessWidget {
  final String privateKeyForDID;

  const VerifyCredentialMenuTile({
    Key? key,
    required this.privateKeyForDID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuTile(
      label: "Verify Credential",
      menuIcon: 'legal_icon.svg',
      onTap: () {
        context.router.push(
          VerifyCredentialRoute(privateKeyForDID: privateKeyForDID),
        );
      },
    );
  }
}

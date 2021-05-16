import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/features/contacts/widgets/contact_tile.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/send.dart';

class SendToAccount extends StatelessWidget {
  final String accountAddress;
  final Token? token;
  final VoidCallback? resetSearch;
  const SendToAccount({
    Key? key,
    required this.accountAddress,
    this.resetSearch,
    this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ContactTile(
          displayName: formatAddress(accountAddress),
          onTap: () {
            resetSearch!();
            sendToPastedAddress(
              accountAddress,
              token: token,
            );
          },
          trailing: InkWell(
            focusColor: Theme.of(context).canvasColor,
            highlightColor: Theme.of(context).canvasColor,
            child: Text(
              I10n.of(context).next_button,
              style: TextStyle(color: Color(0xFF0377FF)),
            ),
            onTap: () {
              resetSearch!();
              sendToPastedAddress(
                accountAddress,
                token: token,
              );
            },
          ),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/widgets/snackbars.dart';

class CopyToClipboard extends StatelessWidget {
  CopyToClipboard({
    required this.content,
    this.textColor,
  });
  final String content;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      child: Text(
        I10n.of(context).copy_to_clipboard,
        style: TextStyle(
          color: this.textColor ?? Theme.of(context).colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () async {
        Clipboard.setData(ClipboardData(text: content));
        showCopiedFlushbar(context);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digitalrand/generated/i18n.dart';

class CopyToClipboard extends StatelessWidget {
  CopyToClipboard({this.context, this.content, this.textColor});
  final BuildContext context;
  final String content;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(I18n.of(context).copy_to_clipboard,
          style: TextStyle(
              color: this.textColor ?? const Color(0xFF546c7c),
              fontSize: 16,
              fontWeight: FontWeight.w500)),
      onTap: () async {
        Clipboard.setData(ClipboardData(text: content));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            I18n.of(context).copied_to_clipboard,
            textAlign: TextAlign.center,
          ),
        ));
      },
    );
  }
}

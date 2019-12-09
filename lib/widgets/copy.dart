import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboard extends StatelessWidget {
  CopyToClipboard({this.context, this.content});
  final BuildContext context;
  final String content;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Text("Copy to clipboard",
          style: TextStyle(
              color: const Color(0xFF546c7c),
              fontSize: 16,
              fontWeight: FontWeight.w500)),
      onTap: () async {
        Clipboard.setData(
            new ClipboardData(text: content));
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(
            "Copied to Clipboard",
            textAlign: TextAlign.center,
          ),
        ));
      },
    );
  }
}
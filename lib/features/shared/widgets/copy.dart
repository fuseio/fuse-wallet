import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class CopyToClipboard extends StatefulWidget {
  const CopyToClipboard({
    Key? key,
    required this.content,
    this.textColor,
  }) : super(key: key);
  final String content;
  final Color? textColor;

  @override
  State<CopyToClipboard> createState() => _CopyToClipboardState();
}

class _CopyToClipboardState extends SfWidget<CopyToClipboard> {
  late Flushbar flush;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      child: Text(
        I10n.of(context).copy_to_clipboard,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
                  widget.textColor ?? Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
      ),
      onTap: () async {
        Clipboard.setData(ClipboardData(text: widget.content));
        super.throwAlert(
          context,
          I10n.of(context).copied_to_clipboard,
          type: AlertsTypeEnum.INFO,
        );
      },
    );
  }
}

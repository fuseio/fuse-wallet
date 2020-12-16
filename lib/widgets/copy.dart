import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboard extends StatelessWidget {
  CopyToClipboard({this.context, this.content, this.textColor});
  final BuildContext context;
  final String content;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(0, 85, 255, 1),
          borderRadius: new BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        alignment: Alignment.center,
        height: 50,
        width: 100,
        // color: Theme.of(context).splashColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.content_copy,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            Text("Copiar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      onTap: () async {
        Clipboard.setData(new ClipboardData(text: content));
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

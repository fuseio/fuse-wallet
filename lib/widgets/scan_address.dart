import 'package:flutter/material.dart';
import 'package:fusecash/utils/send.dart';

class AddressScanner extends StatelessWidget {
  final BuildContext context;
  final String heroTag;
  const AddressScanner({
    Key key,
    this.context,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      child: FloatingActionButton(
        heroTag: heroTag,
        backgroundColor: Color(0xFF292929),
        elevation: 0,
        child: Image.asset(
          'assets/images/scan.png',
          width: 25.0,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: () {
          barcodeScannerHandler(
            context,
          );
        },
      ),
    );
  }
}

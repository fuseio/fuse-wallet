import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class FiatTile extends StatelessWidget {
  FiatTile({
    Key key,
    this.item,
    this.onTap,
    this.symbolHeight = 60.0,
    this.symbolWidth = 60.0,
  }) : super(key: key);
  final Function() onTap;
  final double symbolWidth;
  final double symbolHeight;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 8,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  // Flexible(
                  //   flex: 4,
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: <Widget>[
                  //       // ClipRRect(
                  //       //   borderRadius: BorderRadius.circular(50),
                  //       //   child: token.imageUrl != null &&
                  //       //           token.imageUrl.isNotEmpty
                  //       //       ? CachedNetworkImage(
                  //       //           width: symbolWidth,
                  //       //           height: symbolHeight,
                  //       //           imageUrl: token.imageUrl,
                  //       //           placeholder: (context, url) =>
                  //       //               CircularProgressIndicator(),
                  //       //           errorWidget: (context, url, error) =>
                  //       //               Icon(
                  //       //             Icons.error,
                  //       //             size: 54,
                  //       //           ),
                  //       //         )
                  //       //       : DefaultLogo(
                  //       //           symbol: token?.symbol,
                  //       //           width: symbolWidth,
                  //       //           height: symbolHeight,
                  //       //         ),
                  //       // ),
                  //       // Text(
                  //       //   item.label,
                  //       //   style: TextStyle(
                  //       //     fontSize: 13,
                  //       //     fontWeight: FontWeight.bold,
                  //       //   ),
                  //       //   textAlign: TextAlign.left,
                  //       // )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(width: 10.0),
                  Flexible(
                    flex: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          item.label,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

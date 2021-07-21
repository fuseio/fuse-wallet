import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/utils/url.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class FusePointsExplainedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      automaticallyImplyLeading: false,
      title: 'Fuse Studio',
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //   decoration: BoxDecoration(
            //       color: Color(0xFFECF0F5),
            //       borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
            //       border: Border.all(color: Color(0xFFE4E9F0))),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       Column(
            //         mainAxisSize: MainAxisSize.max,
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           SvgPicture.asset(
            //             "assets/images/fuse-logo.svg",
            //             width: 75,
            //             height: 75,
            //           ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           Text(
            //             '''Fuse Volts was created by the studio as a featured community. Get some Volts for exploring the wallet features:''',
            //             style: TextStyle(
            //               fontSize: 17,
            //             ),
            //             textAlign: TextAlign.center,
            //           ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(left: 10),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisSize: MainAxisSize.max,
            //               children: <Widget>[
            //                 Align(
            //                   alignment: Alignment.centerLeft,
            //                   child: Text(
            //                     'Win up to 30 points!',
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                     ),
            //                   ),
            //                 ),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: <Widget>[
            //                     SvgPicture.asset('assets/images/v_sign.svg'),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       '10 points for installing the app',
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: <Widget>[
            //                     SvgPicture.asset('assets/images/v_sign.svg'),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       '10 points after sending money to a friend',
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: <Widget>[
            //                     SvgPicture.asset('assets/images/v_sign.svg'),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       '10 points for backing-up your wallet',
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            InkWell(
              onTap: () {
                launchUrl('https://studio.fuse.io');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFB1FDC0),
                      Color(0xFFFEFD86),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: SvgPicture.asset('assets/images/lanuch_community.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

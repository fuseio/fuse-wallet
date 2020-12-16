import 'package:esol/generated/i18n.dart';
import 'package:esol/screens/signup/verfiy_face.dart';
import 'package:esol/widgets/custom_rectangle.dart';
import 'package:esol/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class DetectFace extends StatelessWidget {
  const DetectFace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomRectangle(
          borderSize: 20,
          borderColor: Colors.white,
          height: 30.0,
          borderRadius: 40.0,
          child: Padding(
            padding: EdgeInsets.only(left: 18, top: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  I18n.of(context).transactions,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              PhysicalModel(
                elevation: 1,
                shadowColor: Color(0xFF979797),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
                color: Theme.of(context).splashColor,
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                        labelFontWeight: FontWeight.bold,
                        label: 'Déjanos Conocerte',
                        fontSize: 15,
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VeifyFaceDetect(),
                          ));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                  top: -50,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      elevation: 0,
                      shadowColor: Color(0xFF979797),
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Image.asset(
                              'assets/images/alert-icn.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 16,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text('Importante'),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 7,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            )),
                      ),
                    ),
                  )),
            ],
          ),
        )

        // Column(
        //   children: [
        //     // SizedBox(
        //     //   height: MediaQuery.of(context).size.height / 14,
        //     // ),
        //     Expanded(
        //       child: AlertDialog(
        //         elevation: 0,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(25.0),
        //           ),
        //         ),
        //         title: Center(child: Text(" ")),
        //         content: Text(
        //           "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.",
        //           textAlign: TextAlign.center,
        //         ),
        //         actions: [
        //           Center(
        //             child: PrimaryButton(
        //               labelFontWeight: FontWeight.bold,
        //               label: 'Déjanos Conocerte',
        //               fontSize: 15,
        //               onPressed: () async {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => VeifyFaceDetect(),
        //                 ));
        //               },
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // Positioned.fill(
        //     top: 80,
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: Card(
        //         elevation: 0,
        //         shadowColor: Color(0xFF979797),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: const BorderRadius.all(
        //             Radius.circular(32.0),
        //           ),
        //         ),
        //         child: Container(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               SizedBox(
        //                 height: 3,
        //               ),
        //               Image.asset(
        //                 'assets/images/alert-icn.png',
        //                 fit: BoxFit.cover,
        //                 height: MediaQuery.of(context).size.height / 16,
        //               ),
        //               SizedBox(
        //                 height: 6,
        //               ),
        //               Text('Importante'),
        //             ],
        //           ),
        //           height: MediaQuery.of(context).size.height / 7,
        //           width: 110,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(32.0),
        //               )),
        //         ),
        //       ),
        //     )),
      ],
    );
  }
}

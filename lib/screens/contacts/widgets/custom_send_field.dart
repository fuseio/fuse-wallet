// import 'package:esol/screens/home/widgets/feed.dart';
import 'package:esol/screens/misc/about.dart';
import 'package:flutter/material.dart';
import 'package:esol/generated/i18n.dart';
// import 'package:esol/utils/send.dart';
import 'package:esol/widgets/silver_app_bar.dart';

class CustomSendField extends StatelessWidget {
  const CustomSendField({Key key, this.searchController}) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 100.0,
        child: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text('Enviar dinero fuera de tus contactos'),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                color: Theme.of(context).backgroundColor,
                height: 80,
                alignment: Alignment.center,
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: searchController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                launchUrl('tel:${searchController.text}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 55,
                                  width: 100,
                                  // child: Image.asset('assets\images\gift.png'),
                                  decoration: BoxDecoration(
                                    // image: DecorationImage(
                                    //   image: NetworkImage(
                                    //       'https://www.w3schools.com/howto/img_avatar.png'),
                                    //   fit: BoxFit.contain,
                                    // ),
                                    // border: Border.all(
                                    //     // color: Colors.black,
                                    //     // width: 8,
                                    //     ),
                                    color: Theme.of(context).buttonColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .buttonColor
                                            .withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                      child: Text(
                                    I18n.of(context).send_button,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )),
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            icon: Container(
                                height: 20,
                                padding: EdgeInsets.only(left: 5),
                                child: Image.asset('assets/images/phone.png')),
                            // labelText: 'teléfono',
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 45,
                      //   height: 45,
                      //   child: new FloatingActionButton(
                      //       heroTag: 'contacts_list',
                      //       backgroundColor: const Color(0xFF292929),
                      //       elevation: 0,
                      //       child: Image.asset(
                      //         'assets/images/scan.png',
                      //         width: 25.0,
                      //         color: Theme.of(context).scaffoldBackgroundColor,
                      //       ),
                      //       onPressed: bracodeScannerHandler),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

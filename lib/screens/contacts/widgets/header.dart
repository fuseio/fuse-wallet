import 'package:flutter/material.dart';
import 'package:esol/constans/keys.dart';
import 'package:esol/models/views/cash_header.dart';
import 'package:esol/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/utils/send.dart';
import 'package:flutter_svg/svg.dart';

class ContactsHeader extends StatelessWidget {
  final bool imageshow;
  final bool textshow;
  final bool contactEmpty;
  final String text;
  final String avatarUrl;
  final ImageProvider<dynamic> image;
  ContactsHeader(
      {@required this.imageshow,
      @required this.textshow,
      @required this.contactEmpty,
      @required this.image,
      this.avatarUrl,
      this.text});
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CashHeaderViewModel>(
        distinct: true,
        converter: CashHeaderViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 15.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withAlpha(20),
                  blurRadius: 30.0,
                  spreadRadius: 10.0,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                )
              ],
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.only(
                //bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    AppKeys.homePageKey.currentState.openDrawer();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 35, right: 35),
                    child: Image.asset(
                      'assets/images/menu_white.png',
                      width: 20,
                    ),
                  ),
                ),
                //Editing Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: bracodeScannerHandler,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/QR.svg",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'QR',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class HeaderExample extends StatelessWidget {
  final bool imageshow;
  final bool texthide;
  final String textName;
  HeaderExample({
    @required this.imageshow,
    @required this.texthide,
    this.textName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? Text(
                  'S/',
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: 25,
                  ),
                )
              : Text(
                  textName,
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: 16,
                  ),
                ),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? SizedBox(
                  width: 10,
                )
              : SizedBox.shrink(),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? Image.asset('assets/images/conversion_icon.png')
              : SizedBox.shrink(),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? SizedBox(
                  width: 10,
                )
              : SizedBox.shrink(),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? Text(
                  'ESOL',
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: 25,
                  ),
                )
              : SizedBox.shrink(),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? SizedBox(
                  width: 30,
                )
              : SizedBox.shrink(),
      (texthide)
          ? SizedBox.shrink()
          : (textName == null)
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    height: 20,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[600],
                    ),
                    child: Container(
                      height: 10,
                      child: Image.asset(
                        imageshow
                            ? 'assets/images/eye_hide.png'
                            : 'assets/images/eye_show.png',
                        // filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
    ]);
  }
}

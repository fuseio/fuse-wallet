import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactTile extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final String displayName;
  final String phoneNumber;
  final Function onTap;
  final Widget trailing;
  const ContactTile(
      {Key key,
      this.image,
      this.displayName,
      this.phoneNumber,
      this.onTap,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: new BoxDecoration(
            border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE0E0E0),
            radius: 25,
            backgroundImage: image ?? AssetImage('assets/images/anom.png'),
          ),
          title: Text(
            displayName,
            style:
                TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}

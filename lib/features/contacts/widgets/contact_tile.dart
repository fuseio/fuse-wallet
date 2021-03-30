import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactTile extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final String displayName;
  final String phoneNumber;
  final Function onTap;
  final Widget trailing;
  const ContactTile({
    Key key,
    this.image,
    this.displayName,
    this.phoneNumber,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
            ),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 16,
            right: 16,
          ),
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE0E0E0),
            radius: 25,
            backgroundImage: image ?? AssetImage('assets/images/anom.png'),
          ),
          title: Text(
            displayName,
            style: TextStyle(fontSize: 15),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}

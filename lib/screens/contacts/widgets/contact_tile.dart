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
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: image ?? AssetImage('assets/images/anom.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              title: Text(
                displayName,
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).primaryColor),
              ),
              trailing: trailing,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}

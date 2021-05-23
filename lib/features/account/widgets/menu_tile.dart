import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuTile extends StatelessWidget {
  final void Function() onTap;
  final String menuIcon;
  final String label;
  final Widget trailing;

  const MenuTile({
    Key key,
    this.onTap,
    this.menuIcon,
    this.label,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      onTap: onTap,
      title: Row(
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/$menuIcon',
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      trailing: trailing ??
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
    );
  }
}

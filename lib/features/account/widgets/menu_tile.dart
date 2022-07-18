import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuTile extends StatelessWidget {
  final void Function()? onTap;
  final String? menuIcon;
  final String label;
  final double? width;
  final double? height;
  final Widget? trailing;
  final bool withTrailing;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;

  const MenuTile({
    Key? key,
    this.onTap,
    this.contentPadding = const EdgeInsets.only(
      top: 5,
      bottom: 5,
      left: 20,
      right: 20,
    ),
    this.width = 20,
    this.height = 20,
    this.fontSize = 18,
    required this.menuIcon,
    required this.label,
    this.trailing,
    this.withTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      onTap: onTap,
      title: Row(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              'assets/images/$menuIcon',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: fontSize,
                ),
          ),
        ],
      ),
      trailing: withTrailing
          ? trailing ??
              Icon(
                Icons.navigate_next,
                color: Theme.of(context).colorScheme.onSurface,
              )
          : null,
    );
  }
}

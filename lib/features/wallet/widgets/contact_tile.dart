import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final ImageProvider<Object>? image;
  final String displayName;
  final void Function() onTap;
  final Widget? trailing;
  const ContactTile({
    Key? key,
    this.image,
    required this.displayName,
    required this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8E8E8),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 16,
          right: 16,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          radius: 25,
          backgroundImage: image ?? const AssetImage('assets/images/anom.png'),
        ),
        title: Text(
          displayName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
              ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

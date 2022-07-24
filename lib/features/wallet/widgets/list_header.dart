import 'package:flutter/material.dart';

import 'package:fusecash/features/shared/widgets/silver_app_bar.dart';

class ListHeader extends StatelessWidget {
  final String title;
  const ListHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: 40.0,
        maxHeight: 40.0,
        child: Container(
          color: const Color(0xFFF8F8F8),
          padding: const EdgeInsets.only(left: 20, top: 7),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fusecash/features/buy/widgets/item.dart';

class BuyBody extends StatelessWidget {
  const BuyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => WeedItem(),
      separatorBuilder: (_, __) => Divider(color: Colors.grey),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
    );
  }
}

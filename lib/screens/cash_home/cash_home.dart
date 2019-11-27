import 'package:flutter/material.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';

import 'cash_header.dart';
import 'cash_transactions.dart';

class CashHomeScreen extends StatefulWidget {
  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}

class _CashHomeScreenState extends State<CashHomeScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      children: <Widget>[
        CashHeader(),
        CashTransactios()
      ],
    );
  }
}


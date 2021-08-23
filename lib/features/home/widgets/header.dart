import 'package:flutter/material.dart';
import 'package:fusecash/features/home/widgets/balance.dart';
import 'package:fusecash/features/shared/widgets/barcode_scanner.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/redux/viewsmodels/header.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HeaderViewModel>(
      distinct: true,
      converter: HeaderViewModel.fromStore,
      builder: (_, viewModel) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryVariant,
                Theme.of(context).colorScheme.primary,
              ],
            ),
            // color: Colors.amber[600],//TODO: get the exact hex code
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Text(
                  '${I10n.of(context).hi} ${viewModel.firstName()}',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Balance(),
                    BarcodeScanner(
                      backgroundColor: Color.fromRGBO(219,126,0,1),//Colors.amber[800],//todo: make it dynamically responding to the parent widget back color
                      child: Image.asset(
                        'assets/images/scan.png',
                        width: 25.0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

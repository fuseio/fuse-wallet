import 'package:flutter/material.dart';
import 'package:supervecina/constants/strings.dart';
import 'package:supervecina/constants/theme.dart';
import 'package:supervecina/features/home/widgets/balance.dart';
import 'package:supervecina/features/shared/widgets/barcode_scanner.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/redux/viewsmodels/header.dart';
import 'package:supervecina/models/app_state.dart';
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
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '${I10n.of(context).hi} ${viewModel.firstName()}',
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).canvasColor,
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
              Positioned(
                right: 10,
                top: 35,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Strings.appTitle,
                        style: TextStyle(
                          fontFamily: 'Eras',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

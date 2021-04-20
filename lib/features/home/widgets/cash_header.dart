import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/features/home/widgets/balance.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/viewsmodels/cash_header.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/utils/send.dart';

class CashHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CashHeaderViewModel>(
      distinct: true,
      converter: CashHeaderViewModel.fromStore,
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.only(top: 35, right: 35),
                icon: Image.asset(
                  'assets/images/menu.png',
                  // width: 10,
                ),
                onPressed: AppKeys.homePageKey.currentState.openDrawer,
              ),
              Text(
                '${I18n.of(context).hi} ${viewModel?.firstName() ?? ''}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        I18n.of(context).balance,
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.0,
                        ),
                      ),
                      Balance(),
                    ],
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    child: FloatingActionButton(
                      heroTag: 'cash_header',
                      backgroundColor: Color(0xFF292929),
                      elevation: 0,
                      child: Image.asset(
                        'assets/images/scan.png',
                        width: 25.0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      onPressed: () {
                        barcodeScannerHandler(
                          ExtendedNavigator.named('homeRouter').context,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/common/router/routes.gr.dart';

class DepositBanner extends StatelessWidget {
  const DepositBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopupViewModel>(
        distinct: true,
        converter: TopupViewModel.fromStore,
        builder: (_, viewModel) {
          List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
          return InkWell(
            focusColor: Theme.of(context).splashColor,
            highlightColor: Theme.of(context).splashColor,
            onTap: () {
              if (depositPlugins.isNotEmpty) {
                dynamic url = depositPlugins[0].generateUrl();
                viewModel.setDepositBanner();
                ExtendedNavigator.root.pushWebview(
                  withBack: true,
                  url: '$url&finalUrl=https://fuse.io',
                  title: I18n.of(context).deposit_your_first_dollars,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(20),
                    blurRadius: 30.0,
                    spreadRadius: 10.0,
                    offset: Offset(
                      0.0,
                      3.0,
                    ),
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/fuse_dollar.svg',
                  ),
                  Text(
                    I18n.of(context).deposit_your_first_dollars,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/plus.svg',
                  ),
                ],
              ),
            ),
          );
        });
  }
}

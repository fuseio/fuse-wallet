import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/common/router/routes.gr.dart';

class DepositBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopUpViewModel>(
      distinct: true,
      converter: TopUpViewModel.fromStore,
      builder: (_, viewModel) {
        List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              height: 65,
              width: MediaQuery.of(context).size.width * .95,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/deposit.png',
                  ),
                ),
                border: Border.all(
                  color: Color(0xFFEBEBEB),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      I18n.of(context).deposit_your_first_dollars,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  if (depositPlugins.isNotEmpty) {
                    dynamic url = depositPlugins[0].widgetUrl;
                    viewModel.setDepositBanner();
                    ExtendedNavigator.root.pushWebview(
                      withBack: true,
                      url: '$url&finalUrl=https://fuse.io',
                      title: I18n.of(context).deposit_your_first_dollars,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

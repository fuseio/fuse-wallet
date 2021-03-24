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
        return Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            focusColor: Theme.of(context).canvasColor,
            highlightColor: Theme.of(context).canvasColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      I18n.of(context).your_wallet_is_empty,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Text(
                          I18n.of(context).deposit_your_first_dollars,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          right: -20,
                          top: 8,
                          child: Icon(
                            Icons.arrow_right_outlined,
                            color: Theme.of(context).colorScheme.primaryVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/empty_state.png',
                  width: 250,
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
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/utils/webview.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          I18n.of(context).deposit_your_first_dollars,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/images/arrow_right_outlined.svg',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/empty_state.png',
                  height: MediaQuery.of(context).size.height * .2,
                  // width: 250,
                )
              ],
            ),
            onTap: () {
              if (depositPlugins.isNotEmpty) {
                String url = depositPlugins[0].widgetUrl;
                viewModel.setDepositBanner();
                openDepositWebview(
                  withBack: true,
                  url: url,
                );
              }
            },
          ),
        );
      },
    );
  }
}

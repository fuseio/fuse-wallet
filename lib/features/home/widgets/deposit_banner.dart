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
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(
                left: 25,
              ),
              height: 80,
              width: MediaQuery.of(context).size.width * .95,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage(
                    'assets/images/deposit_banner.png',
                  ),
                ),
                border: Border.all(color: Color(0xFFE0E0E0), width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: InkWell(
                      focusColor: Theme.of(context).canvasColor,
                      highlightColor: Theme.of(context).canvasColor,
                      onTap: () {
                        if (depositPlugins.isNotEmpty) {
                          dynamic url = depositPlugins[0].widgetUrl;
                          viewModel.setDepositBanner();
                          openDepositWebview(
                            withBack: true,
                            url: url,
                            title: I18n.of(context).deposit_your_first_dollars,
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                I18n.of(context).deposit_your,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    I18n.of(context).first_dollars,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/deposit_arrow.svg',
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  viewModel.showDismiss
                      ? FlatButton(
                          child: Text(
                            I18n.of(context).dismiss,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Europa',
                              letterSpacing: 0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          textColor: Theme.of(context).colorScheme.onSurface,
                          hoverColor: Theme.of(context).canvasColor,
                          focusColor: Theme.of(context).canvasColor,
                          onPressed: viewModel.dismiss,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 7),
          ],
        );
      },
    );
  }
}

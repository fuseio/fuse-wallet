import 'dart:convert';
import 'package:fusecash/features/shared/dialogs/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/viewsmodels/switch_community.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/features/shared/widgets/community_card.dart';
import 'package:fusecash/features/shared/widgets/community_card_small.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';

class SwitchCommunityScreen extends StatelessWidget {
  Widget scanQRButton(
    BuildContext context,
    Function switchCommunity,
  ) {
    return Container(
      width: 260.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      ),
      child: InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: () async {
          try {
            String? result = await showDialog<String>(
              context: context,
              builder: (context) => ScanQRDialog(),
            );
            log.info('result ${result.toString()}');
            if (result != null) {
              Map jsonMap = jsonDecode(result);
              switchCommunity(jsonMap['communityAddress']);
              context.router.popUntilRoot();
            }
          } catch (e) {
            log.error('BarcodeScanner scan error');
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(I10n.of(context).sqan_qr_code,
                style: TextStyle(
                    color: Theme.of(context).textTheme.button!.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: 'switch_scanner',
                mini: true,
                backgroundColor: Color(0xFF292929),
                elevation: 0,
                child: Image.asset(
                  'assets/images/scan.png',
                  width: 20.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: null,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SwitchCommunityViewModel>(
      converter: SwitchCommunityViewModel.fromStore,
      builder: (_, viewModel) {
        return MyScaffold(
          title: I10n.of(context).switch_community,
          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    I10n.of(context).current_community,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                viewModel.tokens.containsKey(
                        viewModel.currentCommunity.homeTokenAddress)
                    ? SelectedCommunityCard(
                        community: viewModel.currentCommunity,
                        token: viewModel.tokens[
                            viewModel.currentCommunity.homeTokenAddress]!,
                        switchCommunity: viewModel.switchCommunity,
                      )
                    : SizedBox.shrink(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      right: 40,
                      left: 40,
                    ),
                    child: scanQRButton(
                      context,
                      viewModel.switchCommunity,
                    ),
                  ),
                ),
                viewModel.communities.length > 1
                    ? Container(
                        padding: EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          I10n.of(context).my_communities,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                ...viewModel.communities.values
                    .where((Community community) =>
                        community.address != viewModel.currentCommunity.address)
                    .map(
                  (Community community) {
                    return CommunityCard(
                      token: viewModel.tokens[community.homeTokenAddress],
                      community: community,
                      switchCommunity: viewModel.switchCommunity,
                    );
                  },
                ).toList()
              ],
            ),
          ),
        );
      },
    );
  }
}

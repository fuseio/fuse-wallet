import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/viewsmodels/transfer_tile.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/transfer.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:intl/intl.dart';

class ActionTile extends StatelessWidget {
  final WalletAction action;
  final EdgeInsetsGeometry contentPadding;

  ActionTile({
    this.action,
    this.contentPadding = const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 15,
      right: 15,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(action.timestamp);
    return new StoreConnector<AppState, TransferTileViewModel>(
      distinct: true,
      converter: TransferTileViewModel.fromStore,
      builder: (_, viewModel) {
        final Contact contact = getContact(
          action.getSender(),
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        final Community community = action.map(
          depositYourFirstDollar: (value) => null,
          createWallet: (value) => null,
          fiatProcess: (value) => null,
          joinCommunity: (value) =>
              viewModel.communities[value.communityAddress.toLowerCase()],
          fiatDeposit: (value) =>
              viewModel.communities[defaultCommunityAddress.toLowerCase()],
          bonus: (value) => null,
          send: (value) => null,
          receive: (value) => null,
          swap: (value) => null,
        );
        final bool isCommunityToken = ![false, null].contains(
          community?.metadata?.isDefaultImage,
        );
        final ImageProvider<dynamic> image = ImageUrl.getActionImage(
          action,
          contact,
          community,
          action.getSender(),
          viewModel.tokensImages,
        );
        final String displayName = action.map(
          depositYourFirstDollar: (value) => value.getText(),
          createWallet: (value) => value.getText(),
          fiatProcess: (value) => value.getText(),
          joinCommunity: (value) => value.getText(),
          fiatDeposit: (value) => value.getText(),
          bonus: (value) => value.getText(),
          swap: (value) => value.getText(),
          send: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        action.getSender(),
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      action.getSender(),
                      viewModel.reverseContacts,
                      businesses: community?.businesses,
                    )
                  : action.getText(),
          receive: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        action.getSender(),
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      action.getSender(),
                      viewModel.reverseContacts,
                      businesses: community?.businesses,
                    )
                  : action.getText(),
        );
        final String symbol = action.map(
          depositYourFirstDollar: (value) => '',
          createWallet: (value) => '',
          fiatProcess: (value) => '',
          joinCommunity: (value) => '',
          fiatDeposit: (value) => value.tokenSymbol,
          bonus: (value) =>
              viewModel?.tokens[value?.tokenAddress?.toLowerCase()]?.symbol ??
              '',
          send: (value) => value.tokenSymbol,
          receive: (value) => value.tokenSymbol,
          swap: (value) => value.tradeInfo.outputToken,
        );

        final Widget trailing = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: action.isPending()
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: action.isPending()
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
          children: <Widget>[
            action.isGenerateWallet() ||
                    action.isJoinCommunity() ||
                    action.isDepositYourFirstDollar()
                ? Text(
                    DateFormat.jm().format(dateTime),
                    style: TextStyle(
                      color: Color(0xFF8D8D8D),
                      fontSize: 10,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: action.getAmount(),
                                        style: TextStyle(
                                          color: Color(0xFF696969),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' $symbol ',
                                        style: TextStyle(
                                          color: Color(0xFF696969),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              action.getActionIcon()
                            ],
                          ),
                          Positioned(
                            bottom: -20,
                            child: action.isPending()
                                ? Padding(
                                    child: Text(
                                      I18n.of(context).pending,
                                      style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 10,
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 10,
                                    ),
                                  )
                                : Padding(
                                    child: Text(
                                      DateFormat.yMMMMd().format(dateTime),
                                      style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 10,
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 10,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
          ],
        );

        final Widget leading = Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Hero(
              child: CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 21.5,
                backgroundImage: image,
              ),
              tag: action.hashCode,
            ),
            action.isPending()
                ? Container(
                    width: 43,
                    height: 43,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            isCommunityToken && action.isJoinCommunity()
                ? Text(
                    action.map(
                      depositYourFirstDollar: (value) => '',
                      createWallet: (value) => '',
                      fiatProcess: (value) => '',
                      joinCommunity: (value) =>
                          viewModel.tokens[value?.tokenAddress?.toLowerCase()]
                              .symbol ??
                          '',
                      fiatDeposit: (value) => value.tokenSymbol,
                      bonus: (value) => value.tokenSymbol,
                      send: (value) => value.tokenSymbol,
                      receive: (value) => value.tokenSymbol,
                      swap: (value) => '',
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  )
                : SizedBox.shrink(),
            isCommunityToken
                ? Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  )
                : SizedBox.shrink()
          ],
        );

        final Widget title = action.isJoinCommunity()
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Europa',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: action.isJoinCommunity() && action.isPending()
                                ? I18n.of(context).joining
                                : I18n.of(context).joined,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          action.getText() != null
                              ? TextSpan(
                                  text: ' \‘${action.getText()}\’ ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                )
                              : TextSpan(text: ''),
                          TextSpan(
                            text: I18n.of(context).community,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : action.isSwapAction()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        action.map(
                          depositYourFirstDollar: (value) => '',
                          createWallet: (value) => '',
                          fiatProcess: (value) => '',
                          joinCommunity: (value) => '',
                          fiatDeposit: (value) => '',
                          bonus: (value) => '',
                          send: (value) => '',
                          receive: (value) => '',
                          swap: (value) => value.tradeInfo.inputToken,
                        ),
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: SvgPicture.asset(
                          'assets/images/swap_arrow.svg',
                          width: 19,
                          height: 8,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          action.map(
                            depositYourFirstDollar: (value) => '',
                            createWallet: (value) => '',
                            fiatProcess: (value) => '',
                            joinCommunity: (value) => '',
                            fiatDeposit: (value) => '',
                            bonus: (value) => '',
                            send: (value) => '',
                            receive: (value) => '',
                            swap: (value) => value.tradeInfo.outputToken,
                          ),
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          displayName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: action.isDepositYourFirstDollar()
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                      action.isDepositYourFirstDollar()
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  'assets/images/arrow_right_outlined.svg',
                                  color: Colors.black,
                                )
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  );

        final Widget subtitle = action.isGenerateWallet() && action.isPending()
            ? Text(
                I18n.of(context).up_to_10,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            : null;

        return ListTile(
          contentPadding: contentPadding,
          leading: leading,
          trailing: trailing,
          title: title,
          subtitle: subtitle,
          onTap: () {
            List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
            if (action.isDepositYourFirstDollar()) {
              if (depositPlugins.isNotEmpty) {
                String url = depositPlugins[0].widgetUrl;
                openDepositWebview(
                  withBack: true,
                  url: url,
                );
              }
            }
            if (!action.isGenerateWallet() &&
                !action.isJoinCommunity() &&
                !action.isDepositYourFirstDollar()) {
              ExtendedNavigator.root.pushActionDetailsScreen(
                accountAddress: action.getSender(),
                contact: contact,
                displayName: displayName,
                action: action,
                image: image,
                symbol: symbol,
              );
            }
          },
        );
      },
    );
  }
}

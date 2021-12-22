import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/transfer_tile.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/transfer.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:intl/intl.dart';

class ActionTile extends StatelessWidget {
  final WalletAction action;
  final EdgeInsetsGeometry? contentPadding;

  ActionTile({
    required this.action,
    this.contentPadding = const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 15,
      right: 15,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransferTileViewModel>(
      distinct: true,
      converter: TransferTileViewModel.fromStore,
      builder: (_, viewModel) {
        final DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(action.timestamp);
        final Contact? contact = getContact(
          action.getSender(),
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        final Community? community = action.map(
          createWallet: (value) => null,
          joinCommunity: (value) => viewModel.communities[
              value.communityAddress?.toLowerCase() ??
                  defaultCommunityAddress.toLowerCase()],
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
        final ImageProvider<Object>? image = ImageUrl.getActionImage(
          action,
          contact,
          community,
          action.getSender(),
          viewModel.tokensImages,
        );

        final Token? token = action.maybeMap(
          orElse: () => null,
          fiatDeposit: (value) =>
              viewModel.tokens[fuseDollarToken.address.toLowerCase()],
          bonus: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          send: (value) => viewModel.tokens[value.tokenAddress.toLowerCase()],
          receive: (value) =>
              viewModel.tokens[value.tokenAddress.toLowerCase()],
          swap: (value) => viewModel.tokens.values.firstWhere(
            (element) => element.symbol == value.tradeInfo?.outputToken,
          ),
        );
        final String displayName = action.maybeMap(
          orElse: () => action.getText(context),
          send: (value) =>
              contact?.displayName ??
              deducePhoneNumber(
                action.getSender(),
                viewModel.reverseContacts,
              ) ??
              value.getText(context),
          receive: (value) =>
              contact?.displayName ??
              deducePhoneNumber(
                action.getSender(),
                viewModel.reverseContacts,
              ) ??
              value.getText(context),
        );
        final String symbol = action.maybeMap(
          orElse: () => '',
          fiatDeposit: (value) => value.tokenSymbol,
          bonus: (value) => value.tokenSymbol,
          send: (value) => value.tokenSymbol,
          receive: (value) => value.tokenSymbol,
          swap: (value) => value.tradeInfo?.outputToken ?? '',
        );

        final String amount = action.getAmount(
          token?.priceInfo,
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
            action.isGenerateWallet() || action.isJoinCommunity()
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
                        clipBehavior: Clip.none,
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
                                        text: amount,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      if (token?.hasPriceInfo != null &&
                                          token?.hasPriceInfo == true)
                                        TextSpan(
                                          text: ' $symbol',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.5,
                              ),
                              action.getActionIcon()
                            ],
                          ),
                          Positioned(
                            bottom: -20,
                            child: action.isPending()
                                ? Padding(
                                    child: Text(
                                      I10n.of(context).pending,
                                      style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 10,
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 10,
                                    ),
                                  )
                                : SizedBox.shrink(),
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
            CircleAvatar(
              backgroundColor: Color(0xFFE0E0E0),
              radius: 25,
              backgroundImage: image,
            ),
            action.isPending()
                ? Container(
                    width: 50,
                    height: 50,
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
                    symbol,
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
                                ? I10n.of(context).joining
                                : I10n.of(context).joined,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          action.getText(context) != ''
                              ? TextSpan(
                                  text: ' \‘${action.getText(context)}\’ ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                )
                              : TextSpan(text: ''),
                          TextSpan(
                            text: I10n.of(context).community,
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
                        I10n.of(context).swap + ' ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        action.maybeMap(
                          orElse: () => '',
                          swap: (value) => value.tradeInfo?.inputToken ?? '',
                        ),
                        style: TextStyle(
                          fontSize: 17,
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
                      Text(
                        action.maybeMap(
                          orElse: () => '',
                          swap: (value) => value.tradeInfo?.outputToken ?? '',
                        ),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          displayName,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  );

        final Widget? subtitle = Text(
          action.isGenerateWallet() && action.isPending()
              ? I10n.of(context).up_to_10
              : action.getName(context),
          style: TextStyle(
            fontSize: 13,
          ),
        );
        return ListTile(
          contentPadding: contentPadding,
          leading: leading,
          trailing: trailing,
          title: title,
          subtitle: subtitle,
          onTap: () {
            if (!action.isGenerateWallet() && !action.isJoinCommunity()) {
              context.router.push(
                ActionDetailsScreen(
                  action: action,
                  displayName: displayName,
                  accountAddress: action.getSender(),
                  symbol: symbol,
                  image: image,
                  contact: contact,
                ),
              );
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/home/widgets/deposit_dollars.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/feed_tile.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/extensions/string.dart';
import 'package:fusecash/utils/transfer.dart';

class FeedTile extends StatelessWidget {
  final WalletAction action;
  final EdgeInsetsGeometry? contentPadding;

  const FeedTile({
    required this.action,
    this.contentPadding = const EdgeInsets.only(
      top: 35,
      bottom: 20,
      left: 15,
      right: 15,
    ),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (action.isGenerateWallet()) {
      return const DepositDollars();
    }
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(action.timestamp);
    return StoreConnector<AppState, FeedTileViewModel>(
      distinct: true,
      converter: FeedTileViewModel.fromStore,
      builder: (_, viewModel) {
        final Contact? contact = getContact(
          action.getSender(),
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        final ImageProvider<Object> image = action.getImage(
          contact,
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
          swap: (value) => value.tradeInfo == null
              ? Token(
                  address: '',
                  name: '',
                  symbol: '',
                  amount: BigInt.zero,
                  decimals: 0,
                )
              : viewModel.tokens.values.firstWhere(
                  (element) => element.symbol == value.tradeInfo?.outputToken,
                ),
        );

        final String displayName = action.maybeMap(
          orElse: () => action.getText(context),
          send: (value) => value.getText(
            context,
            displayName: contact?.displayName ??
                deducePhoneNumber(
                  action.getSender(),
                  viewModel.reverseContacts,
                ),
          ),
          receive: (value) => value.getText(
            context,
            displayName: contact?.displayName ??
                deducePhoneNumber(
                  action.getSender(),
                  viewModel.reverseContacts,
                ),
          ),
        );

        final String symbol = action.maybeMap(
          orElse: () => '',
          fiatDeposit: (value) => value.tokenSymbol,
          bonus: (value) => value.tokenSymbol,
          send: (value) => value.tokenSymbol,
          receive: (value) => value.tokenSymbol,
          swap: (value) => value.tradeInfo?.outputToken ?? '',
        );

        final String amount = action.getAmount();
        final Widget trailing = action.isFailed()
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  action.getStatusIcon(
                    15,
                    15,
                  ),
                  Text(
                    action.status.toLowerCase().capitalize(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )
            : action.isNFTAction()
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              if (action.maybeMap(
                                orElse: () => true,
                                swap: (value) => value.tradeInfo != null,
                              ))
                                TextSpan(
                                  text: amount,
                                ),
                              TextSpan(
                                text: ' $symbol',
                              ),
                            ],
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      (token?.hasPriceInfo ?? false)
                          ? Flexible(
                              child: Text(
                                action.getAmount(token?.priceInfo),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: const Color(0xFFC5C5C5),
                                    ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );

        final Widget leading = Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -35,
              child: Text(
                DateFormat.yMMMd().format(dateTime),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFC5C5C5),
                    ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: boxShadow,
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.0, 1.0],
                      colors: buttonsGradients,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 25,
                    backgroundImage: image,
                  ),
                ),
                action.isPending()
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        );

        final Widget title = action.isSwapAction()
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${I10n.of(context).swap} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    action.maybeMap(
                      orElse: () => '',
                      swap: (value) => value.tradeInfo?.inputToken ?? '',
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (action.maybeMap(
                    orElse: () => false,
                    swap: (value) => value.tradeInfo != null,
                  ))
                    const SizedBox(
                      width: 5,
                    ),
                  if (action.maybeMap(
                    orElse: () => false,
                    swap: (value) => value.tradeInfo != null,
                  ))
                    Flexible(
                      child: SvgPicture.asset(
                        'assets/images/swap_arrow.svg',
                        width: 19,
                        height: 8,
                      ),
                    ),
                  if (action.maybeMap(
                    orElse: () => false,
                    swap: (value) => value.tradeInfo != null,
                  ))
                    const SizedBox(
                      width: 5,
                    ),
                  if (action.maybeMap(
                    orElse: () => false,
                    swap: (value) => value.tradeInfo != null,
                  ))
                    Text(
                      action.maybeMap(
                        orElse: () => '',
                        swap: (value) => value.tradeInfo?.outputToken ?? '',
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                ],
              )
            : AutoSizeText(
                displayName,
                presetFontSizes: const [16, 15, 14, 13],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge,
              );

        final Widget subtitle = Text(
          action.getSubtitle(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFC5C5C5),
              ),
        );

        return ListTile(
          contentPadding: contentPadding,
          leading: leading,
          trailing: trailing,
          title: title,
          subtitle: subtitle,
          onTap: () {
            context.router.push(
              ActionDetailsRoute(
                action: action,
                displayName: displayName,
                accountAddress: action.getSender(),
                symbol: symbol,
                image: image,
                contact: contact,
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/widgets/scroll_to_hide_widget.dart';
import 'package:fusecash/features/shared/widgets/slide_transition.dart';
import 'package:fusecash/features/shared/widgets/token_activities.dart';
import 'package:fusecash/features/shared/widgets/token_floating_actions.dart';
import 'package:fusecash/features/shared/widgets/token_image.dart';
import 'package:fusecash/features/wallet/widgets/chart.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/token_tile.dart';
import 'package:fusecash/utils/format.dart';

class TokenPage extends StatefulWidget {
  final String tokenAddress;
  const TokenPage({
    Key? key,
    required this.tokenAddress,
  }) : super(key: key);

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            );
    return StoreConnector<AppState, TokenTileViewModel>(
      distinct: true,
      converter: TokenTileViewModel.fromStore,
      onInit: (store) {
        final Token token =
            store.state.cashWalletState.tokens[widget.tokenAddress]!;
        store.dispatch(getTokenWalletActionsCall(token));
      },
      builder: (_, viewModel) {
        final bool isSwappable =
            viewModel.tokensImages.containsKey(widget.tokenAddress);
        final Token token = viewModel.tokens[widget.tokenAddress]!;
        return Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              SliverAppBar(
                surfaceTintColor: Theme.of(context).canvasColor,
                pinned: true,
                leading: BackButton(
                  color: Theme.of(context).colorScheme.primary,
                ),
                backgroundColor: Theme.of(context).canvasColor,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TokenImage(
                                        width: 25,
                                        height: 25,
                                        tokenSymbol: token.symbol,
                                        tokenAddress: widget.tokenAddress,
                                        imageUrl: token.imageUrl,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$${Formatter.smallNumbersConvertor(Decimal.parse(token.priceInfo!.quote))}',
                                        style: textStyle,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        token.name,
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Graph(token: token),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 40,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          I10n.of(context).your_balance,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF6C757D),
                                              ),
                                          softWrap: true,
                                        ),
                                        Text(
                                          '${token.getBalance()} ${token.symbol}',
                                          style: textStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          I10n.of(context).value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF6C757D),
                                              ),
                                          softWrap: true,
                                        ),
                                        Text(
                                          '\$${token.getFiatBalance()}',
                                          style: textStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TokenActivities(
                                walletActions: token.walletActions,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: MySlideTransition(
            delay: 1000,
            begin: const Offset(0.0, 1),
            end: const Offset(0.0, 0.0),
            child: ScrollToHideWidget(
              controller: controller,
              child: TokenActions(
                isSwappable: isSwappable,
                token: token,
              ),
            ),
          ),
        );
      },
    );
  }
}

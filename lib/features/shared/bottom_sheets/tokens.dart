import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:fusecash/features/shared/widgets/token_tile.dart';
import 'package:fusecash/models/tokens/token.dart';

class TokensBottomSheet extends StatelessWidget {
  final String title;
  final List<Token> tokens;
  final Function(Token token) onTap;
  final bool showCurrentPrice;
  const TokensBottomSheet({
    Key? key,
    required this.title,
    required this.tokens,
    required this.onTap,
    required this.showCurrentPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        softWrap: true,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        tokens.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Text(
                                  I10n.of(context).no_swap_option,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: const Color(0xFF979797),
                                      ),
                                ),
                              )
                            : ListView(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  showCurrentPrice
                                      ? ListTile(
                                          contentPadding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                I10n.of(context).price,
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              const Text(
                                                '24H',
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: const ClampingScrollPhysics(),
                                    separatorBuilder: (_, int index) =>
                                        const Divider(
                                      height: 0,
                                    ),
                                    itemCount: tokens.length,
                                    itemBuilder: (context, index) => TokenTile(
                                      token: tokens[index],
                                      showCurrentPrice: showCurrentPrice,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        onTap(tokens[index]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension TokensBottomSheetExtension on TokensBottomSheet {
  Future<T?> showSheet<T>(BuildContext context) => showBarModalBottomSheet(
        useRootNavigator: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (context) => this,
      );
}

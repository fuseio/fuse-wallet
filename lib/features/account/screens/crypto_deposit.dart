import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class CryptoDepositScreen extends StatefulWidget {
  final String link;
  final String text;

  const CryptoDepositScreen(
    this.link,
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  State<CryptoDepositScreen> createState() => _CryptoDepositScreenState();
}

class _CryptoDepositScreenState extends SfWidget<CryptoDepositScreen> {
  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      hasScrollBody: false,
      title: I10n.of(context).top_up,
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/images/fuseswap_topup.svg',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  focusColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: widget.link,
                      ),
                    );
                    super.throwAlert(
                      context,
                      I10n.of(context).copied_to_clipboard,
                      type: AlertsTypeEnum.INFO,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 7,
                        child: Text(
                          widget.link,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Icon(
                          Icons.copy,
                          size: 20,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  I10n.of(context).crypto_deposit_risk,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF797979),
                      ),
                ),
                Text(
                  I10n.of(context).crypto_deposit_risk_2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF797979),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomContent: GradientButton(
        width: MediaQuery.of(context).size.width * .9,
        textColor: Theme.of(context).canvasColor,
        text: I10n.of(context).ok,
        onPressed: AutoRouter.of(context).pop,
      ),
    );
  }
}

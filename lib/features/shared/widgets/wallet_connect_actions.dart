import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';

class YesOrNoActions extends StatelessWidget {
  final String? to;
  final String? value;
  final String? approveBtnText;
  final String? rejectBtnText;
  final void Function() onApprove;
  final void Function() onReject;
  const YesOrNoActions({
    Key? key,
    this.to,
    this.value,
    this.approveBtnText,
    this.rejectBtnText,
    required this.onReject,
    required this.onApprove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        if (to != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  shape: BoxShape.rectangle,
                  color: lightGreen,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Positioned(
                      left: 0,
                      child: Text(
                        '${I10n.of(context).to}: ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            Formatter.formatEthAddress(to),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (value != null && value != '0')
                const SizedBox(
                  height: 20,
                ),
              if (value != null && value != '0')
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                    shape: BoxShape.rectangle,
                    color: lightGreen,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        left: 0,
                        child: Text(
                          '${I10n.of(context).value}: ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '$value ${fuseToken.symbol}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        if (to != null)
          const SizedBox(
            height: 20,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              backgroundColor: const Color(0xFFE2F8ED),
              text: rejectBtnText ?? I10n.of(context).reject,
              onPressed: onReject,
            ),
            GradientButton(
              textColor: Theme.of(context).canvasColor,
              text: approveBtnText ?? I10n.of(context).approve,
              onPressed: onApprove,
            ),
          ],
        ),
      ],
    );
  }
}

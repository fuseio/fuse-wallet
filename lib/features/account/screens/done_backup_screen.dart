import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class DoneBackupPage extends StatelessWidget {
  const DoneBackupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      hasScrollBody: false,
      title: I10n.of(context).back_up,
      bottomContent: GradientButton(
        width: MediaQuery.of(context).size.width * .9,
        text: I10n.of(context).ok,
        textColor: Theme.of(context).canvasColor,
        onPressed: () {
          StoreProvider.of(context).dispatch(BackupSuccess());
          context.router.popUntilRoot();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/wallet_protect.svg',
                fit: BoxFit.cover,
                height: 85,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                I10n.of(context).wallet_protected,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 30,
                ),
                child: Text(
                  I10n.of(context).wallet_protected_text,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

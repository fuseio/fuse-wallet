import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// import 'package:fusecash/features/home/widgets/deposit_dollars_banner.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:lottie/lottie.dart';

class DepositDollars extends StatelessWidget {
  const DepositDollars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopUpViewModel>(
      distinct: true,
      converter: TopUpViewModel.fromStore,
      builder: (_, viewModel) {
        return Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                I10n.of(context).welcome_to_fuse,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                I10n.of(context).welcome_to_fuse_text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      letterSpacing: 0,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Lottie.asset(
                'assets/lottie/home-page_rocket_background.json',
              ),
              // const DepositDollarsBanner(),
            ],
          ),
        );
      },
    );
  }
}

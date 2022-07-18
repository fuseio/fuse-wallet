import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/extensions/string.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({Key? key}) : super(key: key);

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends SfWidget<UserNamePage> {
  final displayNameController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).sign_up,
      padding: EdgeInsets.zero,
      body: StoreConnector<AppState, Function(String)>(
        distinct: true,
        converter: (store) => (String displayName) {
          Analytics.track(eventName: AnalyticsEvents.fillUserName);
          store.dispatch(SetDisplayName(displayName));
          store.dispatch(createAccountWalletCall());
        },
        builder: (_, setDisplayName) {
          return ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      bottom: 0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SvgPicture.asset(
                            'assets/images/username.svg',
                            width: 95,
                            height: 80,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          I10n.of(context).pickup_display_name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          I10n.of(context).pickup_display_name_text,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 10.0),
                        Form(
                          key: _formKey,
                          child: Container(
                            width: 255,
                            color: Theme.of(context).canvasColor,
                            child: TextFormField(
                              validator: (value) => value == null
                                  ? 'Please enter user name'
                                  : null,
                              controller: displayNameController,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                  ),
                              autofocus: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0.0),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                ),
                                fillColor: Theme.of(context).canvasColor,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Center(
                child: GradientButton(
                  text: I10n.of(context).next_button,
                  width: MediaQuery.of(context).size.width * .9,
                  textColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        displayNameController.text != '') {
                      setDisplayName(
                        displayNameController.text.capitalize(),
                      );
                      context.router.push(const ChooseSecurityRoute());
                    } else {
                      super.throwAlert(
                        context,
                        'Please enter user name',
                      );
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

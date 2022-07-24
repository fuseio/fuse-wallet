import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/contacts.dart';
import 'package:fusecash/utils/contacts.dart';

class ContactsConfirmation extends StatefulWidget {
  const ContactsConfirmation({Key? key}) : super(key: key);

  @override
  State<ContactsConfirmation> createState() => _ContactsConfirmationState();
}

class _ContactsConfirmationState extends State<ContactsConfirmation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool isPreloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ContactsViewModel>(
      distinct: true,
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        return ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Theme.of(context).canvasColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            I10n.of(context).sync_contacts,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: SvgPicture.asset(
                              'assets/images/contacts.svg',
                              width: 70.0,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        I10n.of(context).enable_contacts_text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                      Column(
                        children: [
                          Text(
                            I10n.of(context).dont_worry,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            I10n.of(context).enable_text,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: GradientButton(
                          width: MediaQuery.of(context).size.width * .9,
                          textColor: Theme.of(context).canvasColor,
                          preload: isPreloading,
                          disabled: isPreloading,
                          text: I10n.of(context).enable_contacts_access,
                          onPressed: () {
                            setState(() {
                              isPreloading = true;
                            });
                            Contacts.getPermissions().then((bool permission) {
                              if (permission) {
                                viewModel.syncContacts();
                              }
                              Navigator.of(context).pop();
                              setState(() {
                                isPreloading = false;
                              });
                            });
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            viewModel.syncContactsRejected();
                          },
                          child: Text(
                            I10n.of(context).skip_button,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension ContactsConfirmationExtension on ContactsConfirmation {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}

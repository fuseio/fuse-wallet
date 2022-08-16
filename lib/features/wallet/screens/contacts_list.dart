import 'dart:io';

import 'package:flutter/material.dart';

import "package:ethereum_addresses/ethereum_addresses.dart";
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:darq/darq.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:phone_number/phone_number.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/back_btn.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:fusecash/features/wallet/widgets/contact_tile.dart';
import 'package:fusecash/features/wallet/widgets/empty_state.dart';
import 'package:fusecash/features/wallet/widgets/list_header.dart';
import 'package:fusecash/features/wallet/widgets/search_panel.dart';
import 'package:fusecash/features/wallet/widgets/send_to_account.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/contacts.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class ContactsPage extends StatefulWidget {
  final SendFlowArguments? pageArgs;
  const ContactsPage({
    Key? key,
    this.pageArgs,
  }) : super(key: key);
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends SfWidget<ContactsPage> {
  List<Contact> filteredUsers = [];
  TextEditingController searchController = TextEditingController();
  List<Contact> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ContactsViewModel>(
      distinct: true,
      onInit: (store) {
        store.dispatch(loadContacts());
      },
      onInitialBuild: (viewModel) {
        refreshContacts(viewModel.contacts);
      },
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.contacts != newViewModel.contacts) {
          refreshContacts(newViewModel.contacts);
        }
      },
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        return InkWell(
          hoverColor: Theme.of(context).canvasColor,
          splashColor: Theme.of(context).canvasColor,
          focusColor: Theme.of(context).canvasColor,
          highlightColor: Theme.of(context).canvasColor,
          onTap: () {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Theme.of(context).canvasColor,
                  leading: MyBackBtn(
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  pinned: true,
                  expandedHeight: 120,
                  backgroundColor: Theme.of(context).canvasColor,
                  flexibleSpace: CustomizableSpaceBar(
                    builder: (context, scrollingRate) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 17,
                          left: 20 + 20 * scrollingRate,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 1 + 10 * scrollingRate,
                              ),
                              AutoSizeText(
                                I10n.of(context).send_to,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28 - 10 * scrollingRate,
                                    ),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SearchPanel(
                  searchController: searchController,
                  token: widget.pageArgs?.tokenToSend,
                  collectible: widget.pageArgs?.collectible,
                ),
                ..._buildPageList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshContacts(List<Contact> contacts) async {
    if (mounted) {
      setState(() {
        _contacts = contacts;
      });
    }

    filterList();
    searchController.addListener(filterList);

    if (Platform.isAndroid) {
      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return;
          if (mounted) {
            setState(() => contact.avatar = avatar);
          }
        });
      }
    }
  }

  void filterList() {
    List<Contact> users = [];
    users.addAll(_contacts);
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.displayName!
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }

    if (mounted) {
      setState(() {
        filteredUsers = users;
      });
    }
  }

  void resetSearch() {
    if (mounted) {
      setState(() {
        searchController.clear();
      });
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    }
  }

  SliverList listBody(
    List<Contact> group,
  ) {
    List<Widget> listItems = <Widget>[];
    for (Contact user
        in group.distinct((Contact contact) => contact.displayName!)) {
      Iterable<Item> phones = user.phones!
          .map((e) => Item(value: clearNotNumbersAndPlusSymbol(e.value!)))
          .toSet()
          .toList()
          .distinct();
      for (Item phone in phones) {
        listItems.add(
          ContactTile(
            displayName: user.displayName!,
            image: user.avatar != null && (user.avatar?.isNotEmpty ?? false)
                ? MemoryImage(user.avatar!)
                : null,
            trailing: Text(
              phone.value!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                  ),
            ),
            onTap: () {
              final store = StoreProvider.of<AppState>(context);
              resetSearch();
              context.loaderOverlay.hide();
              fetchWalletByPhone(
                phone.value!,
                store.state.userState.countryCode,
                store.state.userState.isoCode,
              ).then(
                (walletData) {
                  if (walletData != null) {
                    context.loaderOverlay.hide();
                    final args = SendFlowArguments(
                      phoneNumber: walletData['phoneNumber'],
                      accountAddress: walletData['walletAddress'],
                      avatar: const AssetImage('assets/images/anom.png'),
                      name: user.displayName!,
                      tokenToSend: widget.pageArgs?.tokenToSend,
                      collectible: widget.pageArgs?.collectible,
                    );
                    if (args.collectible != null) {
                      context.navigateTo(
                        WalletTab(
                          children: [
                            const WalletRoute(),
                            ContactsRoute(
                              pageArgs: args,
                            ),
                            SendReviewRoute(
                              pageArgs: args,
                            ),
                          ],
                        ),
                      );
                    } else {
                      context.navigateTo(
                        WalletTab(
                          children: [
                            const WalletRoute(),
                            ContactsRoute(
                              pageArgs: args,
                            ),
                            SendAmountRoute(
                              pageArgs: args,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                onError: (e, s) {
                  log.info(
                    'error fetching wallet by phone number',
                    error: e,
                    stackTrace: s,
                  );
                  super.throwAlert(
                    context,
                    I10n.of(context).something_went_wrong,
                    type: AlertsTypeEnum.ERROR,
                  );
                },
              );
            },
          ),
        );
      }
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  List<Widget> _buildPageList() {
    List<Widget> listItems = [];

    final String accountAddress = ![null, ''].contains(searchController.text) &&
            searchController.text.length > 1 &&
            searchController.text[1] == 'f'
        ? searchController.text.replaceFirst('f', 'x')
        : searchController.text;
    if (isValidEthereumAddress(accountAddress)) {
      listItems.add(
        SendToAccount(
          accountAddress: accountAddress,
          resetSearch: resetSearch,
          token: widget.pageArgs?.tokenToSend,
          collectible: widget.pageArgs?.collectible,
        ),
      );
    } else {
      Map<String, List<Contact>> groups = {};
      for (Contact c in filteredUsers) {
        String groupName = c.displayName![0];
        if (!groups.containsKey(groupName)) {
          groups[groupName] = [];
        }
        groups[groupName]!.add(c);
      }

      if (_contacts.isEmpty) {
        listItems.add(SliverList(
          delegate: SliverChildListDelegate([
            const EmptyState(),
          ]),
        ));
      } else {
        if (groups.isEmpty) {
          listItems.add(SliverList(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    '${I10n.of(context).no_results_found} ${searchController.text}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ]),
          ));
        } else {
          List<String> titles = groups.keys.toList()..sort();
          for (String title in titles) {
            List<Contact> group = groups[title]!;
            listItems.add(ListHeader(title: title));
            listItems.add(listBody(group));
          }
        }
      }
    }

    return listItems;
  }
}

extension ContactsPageExtension on State<ContactsPage> {
  Future<Map?> fetchWalletByPhone(
    String phone,
    String countryCode,
    String isoCode,
  ) async {
    try {
      PhoneNumber phoneNumber = await phoneNumberUtil.parse(
        phone,
        regionCode: isoCode,
      );
      Map? wallet = await chargeApi.getWalletByPhoneNumber(phoneNumber.e164);
      String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      return {
        'phoneNumber': phoneNumber.e164,
        'walletAddress': walletAddress,
      };
    } catch (e, s) {
      String formatted = formatPhoneNumber(phone, countryCode);
      bool isValid = await phoneNumberUtil.validate(
        formatted,
        regionCode: isoCode,
      );
      if (isValid) {
        PhoneNumber phoneNumber = await phoneNumberUtil.parse(
          formatted,
          regionCode: isoCode,
        );
        Map? wallet = await chargeApi.getWalletByPhoneNumber(phoneNumber.e164);
        if (wallet != null) {
          if (wallet["walletAddress"] != null) {
            String walletAddress = wallet["walletAddress"];
            return {
              'phoneNumber': phoneNumber.e164,
              'walletAddress': walletAddress,
            };
          } else {
            throw '$phone Phone number isnt valid - $e';
          }
        } else {
          throw '$phone Phone number isnt valid - $e';
        }
      } else {
        log.error(
          'ERROR - fetchWalletByPhone',
          error: e,
          stackTrace: s,
        );
        rethrow;
      }
    }
  }
}

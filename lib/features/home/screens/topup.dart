import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/top_up.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/common/router/routes.gr.dart';

final List<Item> fiatCurrencies = [
  Item(label: 'USD', value: 'USD'),
  Item(label: 'GBP', value: 'GBP'),
  Item(label: 'EUR', value: 'EUR'),
];

class TopupScreen extends StatefulWidget {
  final String walletAddress;
  TopupScreen({this.walletAddress});
  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "100";
  bool isPreloading = false;
  Item selectedToken = fiatCurrencies[0];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/topup-screen');
  }

  // showBottomMenu() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20.0),
  //         topRight: Radius.circular(20.0),
  //       ),
  //     ),
  //     builder: (BuildContext context) => Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(30.0),
  //           topRight: Radius.circular(30.0),
  //         ),
  //         color: Theme.of(context).splashColor,
  //       ),
  //       child: CustomScrollView(
  //         slivers: <Widget>[
  //           SliverList(
  //             delegate: SliverChildListDelegate(
  //               [
  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     ListView.separated(
  //                       shrinkWrap: true,
  //                       primary: false,
  //                       padding: EdgeInsets.only(top: 20, bottom: 20),
  //                       separatorBuilder: (BuildContext context, int index) =>
  //                           Divider(
  //                         color: Color(0xFFE8E8E8),
  //                         height: 0,
  //                       ),
  //                       itemCount: fiatCurrencies?.length ?? 0,
  //                       itemBuilder: (context, index) => FiatTile(
  //                         item: fiatCurrencies[index],
  //                         onTap: () {
  //                           Navigator.of(context).pop();
  //                           setState(() {
  //                             amountText = "0";
  //                             selectedToken = fiatCurrencies[index];
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    _onKeyPress(VirtualKeyboardKey key) {
      if (key.keyType == VirtualKeyboardKeyType.String) {
        if (amountText == "") {
          amountText = "0";
        }
        if (amountText == "0") {
          amountText = "";
        }
        amountText = amountText + key.text;
      } else if (key.keyType == VirtualKeyboardKeyType.Action) {
        switch (key.action) {
          case VirtualKeyboardKeyAction.Backspace:
            if (amountText.length == 0) return;
            amountText = amountText.substring(0, amountText.length - 1);
            break;
          case VirtualKeyboardKeyAction.Return:
            amountText = amountText + '\n';
            break;
          case VirtualKeyboardKeyAction.Space:
            amountText = amountText + key.text;
            break;
          default:
        }
      }
      setState(() {});
    }

    return MainScaffold(
      withPadding: true,
      title: I18n.of(context).deposit_your_first_dollars,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      I18n.of(context).how_much,
                      style: TextStyle(color: Color(0xFF898989)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                            amountText,
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        InkWell(
                          // onTap: showBottomMenu,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  selectedToken?.value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF808080),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  'assets/images/dropdown_icon.svg',
                                  width: 9,
                                  height: 9,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Divider(
                      color: Color(0xFFE8E8E8),
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
              VirtualKeyboard(
                fontSize: 28,
                alwaysCaps: true,
                height: MediaQuery.of(context).size.height * 0.3,
                textColor: Theme.of(context).primaryColor,
                type: VirtualKeyboardType.Numeric,
                onKeyPress: _onKeyPress,
              ),
            ],
          ),
        )
      ],
      footer: StoreConnector<AppState, TopupViewModel>(
        distinct: true,
        converter: TopupViewModel.fromStore,
        builder: (_, viewModel) {
          List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
          dynamic url = depositPlugins[0]?.generateUrl() ?? '';
          return Center(
            child: PrimaryButton(
              opacity: 1,
              labelFontWeight: FontWeight.normal,
              label: I18n.of(context).continue_with +
                  ' $amountText ${selectedToken?.value}',
              onPressed: () {
                ExtendedNavigator.root.pushWebview(
                  withBack: true,
                  url:
                      '$url&fiatCurrency=${selectedToken?.value}&fiatValue=$amountText&finalUrl=https://fuse.io',
                  title: I18n.of(context).deposit_your_first_dollars,
                );
              },
              preload: isPreloading,
              disabled: isPreloading || url.isEmpty,
              width: 300,
            ),
          );
        },
      ),
    );
  }
}

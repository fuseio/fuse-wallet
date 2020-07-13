import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/views/send_amount.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SendAmountScreen extends StatefulWidget {
  final SendAmountArguments pageArgs;
  SendAmountScreen({this.pageArgs});
  @override
  _SendAmountScreenState createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen>
    with SingleTickerProviderStateMixin {
  String amountText = "0";
  AnimationController controller;
  Animation<Offset> offset;
  bool isPreloading = false;
  Token selectedToken;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/send-amount-screen');
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
  }

  showBottomMenu(SendAmountViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (BuildContext context) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Theme.of(context).splashColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 20),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: viewModel.tokens?.length ?? 0,
                    itemBuilder: (context, index) => OptionTile(
                        token: viewModel.tokens[index],
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            amountText = "0";
                            selectedToken = viewModel.tokens[index];
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    String title =
        "${I18n.of(context).send_to} ${args.name != null ? args.name : formatAddress(args.accountAddress)}";
    return new StoreConnector<AppState, SendAmountViewModel>(
      converter: SendAmountViewModel.fromStore,
      onInitialBuild: (viewModel) {
        if ([null, ''].contains(args.tokenToSend)) {
          setState(() {
            selectedToken = viewModel.tokens[0];
          });
        } else {
          setState(() {
            selectedToken = args.tokenToSend;
          });
        }
      },
      builder: (_, viewModel) {
        _onKeyPress(VirtualKeyboardKey key) {
          if (key.keyType == VirtualKeyboardKeyType.String) {
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
          if (amountText == "") {
            amountText = "0";
          }
          try {
            double amount = double.parse(amountText);
            if (amount > 0 &&
                selectedToken.amount >=
                    toBigInt(amount, selectedToken.decimals)) {
              controller.forward();
            } else {
              controller.reverse();
            }
          } catch (e) {
            controller.reverse();
          }
        }

        return MainScaffold(
            withPadding: true,
            title: title,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  I18n.of(context).how_much,
                                  style: TextStyle(color: Color(0xFF898989)),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        String max = formatValue(
                                            selectedToken.amount,
                                            selectedToken.decimals,
                                            withPrecision: true);
                                        _onKeyPress(VirtualKeyboardKey(
                                            text: max,
                                            keyType:
                                                VirtualKeyboardKeyType.String));
                                      },
                                      child: Text(
                                        I18n.of(context).use_max,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
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
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showBottomMenu(viewModel);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            selectedToken?.symbol ?? '',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF808080)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/dropdown_icon.svg',
                                            width: 15,
                                            height: 15,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Divider(
                              color: Color(0xFFDEDEDE),
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                      VirtualKeyboard(
                          height: MediaQuery.of(context).size.height * 0.37,
                          fontSize: 28,
                          alwaysCaps: true,
                          textColor: Theme.of(context).primaryColor,
                          type: VirtualKeyboardType.Numeric,
                          onKeyPress: _onKeyPress),
                    ]),
              )
            ],
            footer: Center(
                child: SlideTransition(
              position: offset,
              child: PrimaryButton(
                labelFontWeight: FontWeight.normal,
                label: I18n.of(context).continue_with +
                    ' $amountText ${selectedToken?.symbol}',
                onPressed: () {
                  args.tokenToSend = selectedToken;
                  args.amount = num.parse(amountText);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SendReviewScreen(
                                pageArgs: args,
                              )));
                },
                preload: isPreloading,
                disabled: isPreloading,
                width: 300,
              ),
            )));
      },
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({Key key, this.token, this.onTap}) : super(key: key);
  final Token token;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final String price = prices.containsKey(token.symbol)
        ? getDollarValue(token.amount, token.decimals, prices[token.symbol])
        : '0';
    bool isFuseTxs = token.originNetwork != null;
    return Container(
      child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                width: 45,
                                height: 45,
                                imageUrl: token.imageUrl != null &&
                                        token.imageUrl.isNotEmpty
                                    ? token.imageUrl
                                    : getTokenUrl(
                                        checksumEthereumAddress(token.address)),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  size: 54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: token.name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF333333))),
                                    TextSpan(
                                        text: isFuseTxs
                                            ? ' - Fuse'
                                            : ' - Ethereum',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF808080))),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: <Widget>[
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  prices.containsKey(token.symbol)
                                      ? TextSpan(
                                          text: '\$' + price,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : TextSpan(
                                          text: token.getBalance() +
                                              ' ' +
                                              token.symbol,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ])),
                                prices.containsKey(token.symbol)
                                    ? Positioned(
                                        bottom: -20,
                                        child: Padding(
                                            child: Text(
                                                token.getBalance() +
                                                    ' ' +
                                                    token.symbol,
                                                style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 10)),
                                            padding: EdgeInsets.only(top: 10)))
                                    : SizedBox.shrink()
                              ],
                            )
                          ],
                        )
                      ]))
            ],
          )),
    );
  }
}

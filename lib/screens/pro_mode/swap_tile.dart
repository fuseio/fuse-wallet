import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/jobs/swap_token_job.dart';
import 'package:digitalrand/screens/pro_mode/assets_list.dart';

class SwapTokenTile extends StatelessWidget {
  final SwapTokenJob swapToken;
  SwapTokenTile({this.swapToken});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: NetworkImage(
                                  getTokenUrl(checksumEthereumAddress(
                                      swapToken.arguments['toToken'].address)),
                                ),
                              ),
                              tag: swapToken.arguments['toToken'].symbol,
                            ),
                            swapToken.isPending()
                                ? Container(
                                    width: 55,
                                    height: 55,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth: 3,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF49D88D).withOpacity(1)),
                                    ))
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(
                            '${swapToken.arguments['fromToken'].symbol} ${I18n.of(context).to} ${swapToken.arguments['toToken'].symbol}',
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
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
                                new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                      text: swapToken.status,
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ])),
                                swapToken.isFailed()
                                    ? Positioned(
                                        left: -25,
                                        child: SvgPicture.asset(
                                            'assets/images/failed.svg'),
                                      )
                                    : SizedBox.shrink(),
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

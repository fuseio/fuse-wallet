import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/price_diff.dart';
import 'package:number_display/number_display.dart';

class PriceDiff extends StatefulWidget {
  final String tokenAddress;
  const PriceDiff({
    Key? key,
    required this.tokenAddress,
  }) : super(key: key);

  @override
  _PriceDiffState createState() => _PriceDiffState();
}

class _PriceDiffState extends State<PriceDiff> {
  String limit = '7';

  Widget _limitButton(
    Token token,
    Function(
      Token token,
      String limit,
    )
        fetchPriceDiff,
    String value,
    String l,
  ) {
    return InkWell(
      onTap: () {
        fetchPriceDiff(token, l);
        setState(() {
          limit = limit;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              5.0,
            ),
          ),
          color: token.priceDiffLimitInDays.toString() == l
              ? Theme.of(context).colorScheme.onSurface
              : Color(0xFFE6E6E6),
        ),
        alignment: Alignment.center,
        width: 47,
        height: 26,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: token.priceDiffLimitInDays.toString() == l
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget price(num priceChange) {
    final Display display = createDisplay(
      decimal: 1,
    );
    if (priceChange.isNegative) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            display(priceChange) + '%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(
                0xFFFF635C,
              ),
            ),
          ),
          SizedBox(
            width: 2.5,
          ),
          SvgPicture.asset(
            'assets/images/percent_down.svg',
          ),
        ],
      );
    } else if (priceChange.toStringAsFixed(2).startsWith('0.00') ||
        priceChange.toStringAsFixed(2).startsWith('-0.00')) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            display(priceChange) + '%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF292929,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            display(priceChange) + '%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: 2.5,
          ),
          SvgPicture.asset(
            'assets/images/percent_up.svg',
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PriceDiffViewModel>(
      distinct: true,
      converter: PriceDiffViewModel.fromStore,
      onInit: (store) {
        final Token? token =
            store.state.cashWalletState.tokens[widget.tokenAddress];
        store.dispatch(
          getTokenPriceDiffCall(
            widget.tokenAddress,
            limit,
          ),
        );
        if (token != null) {
          store.dispatch(
            getTokenStatsCall(
              token,
              limit: limit,
            ),
          );
        }
      },
      builder: (_, viewModel) {
        final Token? token = viewModel.tokens[widget.tokenAddress];
        final num priceChange = token?.priceDiff ?? 0;
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  price(priceChange),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // _limitButton(
                        //   token!,
                        //   viewModel.fetchPriceDiff,
                        //   '24H',
                        //   '1',
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        _limitButton(
                          token!,
                          viewModel.fetchPriceDiff,
                          '1W',
                          '7',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        _limitButton(
                          token,
                          viewModel.fetchPriceDiff,
                          '1M',
                          '30',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

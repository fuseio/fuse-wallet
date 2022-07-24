import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/constants/enum.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class Option {
  final String title;
  final TimeFrame timeFrame;
  Option({
    required this.title,
    required this.timeFrame,
  });
}

typedef Options = List<Option>;

final Options options = [
  Option(
    title: '1H',
    timeFrame: TimeFrame.hour,
  ),
  Option(
    title: '1D',
    timeFrame: TimeFrame.day,
  ),
  Option(
    title: '1W',
    timeFrame: TimeFrame.week,
  ),
  Option(
    title: '1M',
    timeFrame: TimeFrame.month,
  ),
];

typedef FetchChartData = Function(
  String tokenAddress, {
  TimeFrame? timeFrame,
});

class ChartFilterOptions extends StatefulWidget {
  final Token token;
  const ChartFilterOptions({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ChartFilterOptions> createState() => _ChartFilterOptionsState();
}

class _ChartFilterOptionsState extends State<ChartFilterOptions> {
  int currentIndex = 0;

  Widget _filterButton(
    Option option,
    FetchChartData fetchChartData,
  ) {
    return InkWell(
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      onTap: () {
        fetchChartData(
          widget.token.address,
          timeFrame: option.timeFrame,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              7.0,
            ),
          ),
          color: option.timeFrame == widget.token.timeFrame
              ? lightGreenShadow
              : null,
        ),
        alignment: Alignment.center,
        width: 70,
        height: 30,
        child: Center(
          child: Text(
            option.title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FetchChartData>(
      distinct: true,
      converter: (store) => (
        String tokenAddress, {
        TimeFrame? timeFrame,
      }) {
        store.dispatch(
          getTokenIntervalStatsCall(
            widget.token,
            timeFrame: timeFrame!,
          ),
        );
      },
      builder: (_, FetchChartData fetchChartData) {
        return Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...options.map(
                (e) => _filterButton(
                  e,
                  fetchChartData,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

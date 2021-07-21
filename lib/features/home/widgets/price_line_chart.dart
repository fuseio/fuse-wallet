import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:fusecash/redux/viewsmodels/action_details.dart';

class PriceLineChart extends StatelessWidget {
  final String tokenAddress;
  const PriceLineChart({
    Key? key,
    required this.tokenAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ActionDetailsViewModel>(
      distinct: true,
      converter: ActionDetailsViewModel.fromStore,
      builder: (_, viewModel) {
        final List<Stats>? stats = viewModel.tokens[tokenAddress]!.stats;
        if (stats == null || stats.isEmpty || stats.length < 2) {
          return SizedBox.shrink();
        }
        final lineBarsData = [
          LineChartBarData(
            spots: stats
                .asMap()
                .map(
                  (i, elem) => MapEntry(
                    i,
                    FlSpot(
                      i.toDouble(),
                      double.parse(
                        double.parse(elem.price!).toStringAsFixed(2),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
            isCurved: true,
            colors: [Colors.black, Colors.black],
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 50,
              child: Center(
                child: LineChart(
                  LineChartData(
                    lineBarsData: lineBarsData,
                    gridData: FlGridData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      getTouchedSpotIndicator: (barData, spotIndexes) =>
                          spotIndexes
                              .map(
                                (index) => TouchedSpotIndicatorData(
                                  FlLine(
                                    color: Colors.transparent,
                                  ),
                                  FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                      radius: 0,
                                      color: Colors.transparent,
                                      strokeWidth: 0,
                                      strokeColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Theme.of(context).primaryColor,
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (lineBarsSpot) => lineBarsSpot.map(
                          (lineBarSpot) {
                            return LineTooltipItem(
                              '\$' + lineBarSpot.y.toString(),
                              const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                // fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

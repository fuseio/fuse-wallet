import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/home/widgets/price_change.dart';
import 'package:fusecash/utils/format.dart';

class PriceLineChart extends StatefulWidget {
  final List<IntervalStats> intervalStats;
  final num priceChange;
  final TimeFrame timeFrame;
  const PriceLineChart({
    Key? key,
    required this.intervalStats,
    required this.priceChange,
    required this.timeFrame,
  }) : super(key: key);

  @override
  State<PriceLineChart> createState() => _PriceLineChartState();
}

class _PriceLineChartState extends State<PriceLineChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.intervalStats.isEmpty || widget.intervalStats.length < 2) {
      return const SizedBox.shrink();
    }
    final List<FlSpot> spots = widget.intervalStats
        .toList()
        .asMap()
        .map((i, elem) => MapEntry(i, FlSpot(i.toDouble(), elem.currentPrice)))
        .values
        .toList();

    final List<LineChartBarData> lineBarsData = [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: Theme.of(context).colorScheme.primary,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];

    return SizedBox(
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          LineChart(
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
                getTouchedSpotIndicator: (barData, spotIndexes) => spotIndexes
                    .map(
                      (index) => TouchedSpotIndicatorData(
                        FlLine(
                          color: Colors.transparent,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
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
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  tooltipBgColor: lightGreenShadow,
                  tooltipRoundedRadius: 10,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) =>
                      lineBarsSpot
                          .map(
                            (LineBarSpot lineBarSpot) => LineTooltipItem(
                              '\$${Formatter.padZeroIfNeeded(
                                Decimal.parse(
                                  lineBarSpot.y.toString(),
                                ),
                              )}',
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: homeBannerLightGreen,
                                    fontSize: 13,
                                  ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
          Positioned(
            top: -82,
            right: 0,
            child: _Price(
              timeFrame: widget.timeFrame,
              priceChange: widget.priceChange,
            ),
          ),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  final num priceChange;
  final TimeFrame timeFrame;
  const _Price({
    Key? key,
    required this.priceChange,
    required this.timeFrame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String value = '${display(priceChange)}%';
    if (priceChange.isNegative) {
      return _RowItem(
        timeFrame: timeFrame,
        text: value,
        color: const Color(0xFFF85050),
        logo: const Icon(
          Icons.arrow_downward_rounded,
          color: Color(0xFFF85050),
        ),
      );
    } else if (priceChange.toStringAsFixed(2).startsWith('0.00') ||
        priceChange.toStringAsFixed(2).startsWith('-0.00')) {
      return _RowItem(
        timeFrame: timeFrame,
        text: value,
        color: const Color(0xFF292929),
      );
    } else {
      return _RowItem(
        text: '+$value',
        timeFrame: timeFrame,
        color: const Color(0xFF38D989),
        logo: Icon(
          Icons.arrow_upward_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }
}

class _RowItem extends StatelessWidget {
  final String text;
  final Widget? logo;
  final Color color;
  final TimeFrame timeFrame;
  const _RowItem({
    Key? key,
    required this.text,
    required this.timeFrame,
    required this.color,
    this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              logo != null ? logo! : const SizedBox.shrink(),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
              ),
            ],
          ),
          Text(
            '${I10n.of(context).last} ${timeFrame.name}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// import 'package:collection/collection.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:fusecash/models/tokens/stats.dart';

// class PriceLineChart extends StatelessWidget {
//   final List<Stats> stats;
//   const PriceLineChart({
//     Key? key,
//     required this.stats,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       // mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           // color: Theme.of(context).colorScheme.secondary,
//           height: 150,
//           child: Center(
//             child: LineChart(
//               LineChartData(
//                 gridData: FlGridData(
//                   show: false,
//                 ),
//                 titlesData: FlTitlesData(
//                   show: false,
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 lineTouchData: LineTouchData(
//                   enabled: true,
//                   getTouchedSpotIndicator:
//                       (LineChartBarData barData, List<int> spotIndexes) {
//                     return spotIndexes
//                         .map(
//                           (index) => TouchedSpotIndicatorData(
//                             FlLine(
//                               color: Colors.transparent,
//                             ),
//                             FlDotData(
//                               show: true,
//                               getDotPainter: (spot, percent, barData, index) =>
//                                   FlDotCirclePainter(
//                                 radius: 0,
//                                 color: Colors.transparent,
//                                 strokeWidth: 0,
//                                 strokeColor: Colors.transparent,
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList();
//                   },
//                   touchTooltipData: LineTouchTooltipData(
//                     tooltipBgColor: Theme.of(context).primaryColor,
//                     tooltipRoundedRadius: 8,
//                     getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                       return lineBarsSpot.map((lineBarSpot) {
//                         return LineTooltipItem(
//                           lineBarSpot.y.toString(),
//                           const TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         );
//                       }).toList();
//                     },
//                   ),
//                 ),
//                 backgroundColor: Theme.of(context).colorScheme.secondary,
//                 minX: minBy(stats?.map((e) => double.parse(e.price)), (a) => a),
//                 minY: minBy(stats?.map((e) => double.parse(e.price)), (a) => a),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: stats
//                         ?.asMap()
//                         ?.map(
//                           (i, elem) => MapEntry(
//                             i,
//                             FlSpot(
//                               i.toDouble(),
//                               double.parse(
//                                 double.parse(elem.price).toStringAsFixed(2),
//                               ),
//                             ),
//                           ),
//                         )
//                         ?.values
//                         ?.toList(),
//                     isCurved: true,
//                     colors: [Colors.black, Colors.black],
//                     barWidth: 4,
//                     isStrokeCapRound: true,
//                     dotData: FlDotData(
//                       show: false,
//                     ),
//                     belowBarData: BarAreaData(
//                       show: true,
//                       colors: [
//                         Theme.of(context).primaryColor,
//                         Theme.of(context).colorScheme.primaryVariant,
//                       ].map((color) => color.withOpacity(0.3)).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

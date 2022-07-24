import 'package:flutter/material.dart';

import 'package:fusecash/features/wallet/widgets/chart_filter_options.dart';
import 'package:fusecash/features/wallet/widgets/price_line_chart.dart';
import 'package:fusecash/models/tokens/token.dart';

class Graph extends StatefulWidget {
  final Token token;
  const Graph({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    if (widget.token.intervalStats.isEmpty ||
        widget.token.intervalStats.length < 2) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 40,
        ),
        PriceLineChart(
          timeFrame: widget.token.timeFrame,
          priceChange: widget.token.priceChange,
          intervalStats: widget.token.intervalStats,
        ),
        const SizedBox(
          height: 20,
        ),
        ChartFilterOptions(
          token: widget.token,
        ),
      ],
    );
  }
}

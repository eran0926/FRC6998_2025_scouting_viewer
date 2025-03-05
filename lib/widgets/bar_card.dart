import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:viewer/constants.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/chart_legend_widget.dart';

class BarCard extends StatelessWidget {
  final String title;
  final double start;
  final double end;
  final double minY;
  final double maxY;
  const BarCard(
      {super.key,
      this.title = '',
      this.start = 0,
      required this.end,
      this.minY = 0,
      this.maxY = 100});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        title: title,
        // aspectRatio: 10,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BarChart(BarChartData(
            rotationQuarterTurns: 1,
            minY: minY,
            maxY: maxY,
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(toY: end, color: chartColorSet[0])
              ]),
            ],
            titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                )),
            barTouchData: BarTouchData(
              // enabled: false,
              touchTooltipData: BarTouchTooltipData(
                // getTooltipColor: (group) => Colors.transparent,
                // tooltipPadding: EdgeInsets.zero,
                // tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    num.parse(rod.toY.toStringAsFixed(2)).toString(),
                    const TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          )),
        ));
  }
}

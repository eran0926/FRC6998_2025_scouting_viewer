import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:viewer/constants.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/chart_legend_widget.dart';

class BarChartCard extends StatelessWidget {
  final String title;
  Map<String, List<double>> data;
  List<String> legends;
  BarChartCard(
      {super.key, this.title = '', required this.data, required this.legends});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        title: title,
        aspectRatio: 1.3,
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: BarChart(BarChartData(
                    barGroups: [
                      for (var rods in data.values.toList().asMap().entries)
                        BarChartGroupData(
                          x: rods.key,
                          barRods: [
                            for (var rod in rods.value.asMap().entries)
                              BarChartRodData(
                                toY: rod.value,
                                color: chartColorSet[
                                    rod.key % chartColorSet.length],
                              ),
                          ],
                          showingTooltipIndicators: List.generate(
                              rods.value.length, (index) => index),
                        ),
                    ],
                    titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 35,
                                getTitlesWidget: (value, meta) =>
                                    SideTitleWidget(
                                      meta: meta,
                                      child: Text(
                                          data.keys.toList()[value.toInt()]),
                                    ))),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        )),
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.transparent,
                        tooltipPadding: EdgeInsets.zero,
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.toY.round().toString(),
                            const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ))),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: legends.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return ChartLegend(
                      color: chartColorSet[index % chartColorSet.length],
                      text: item,
                      isSquare: false,
                      size: 16,
                      textColor: const Color.fromARGB(255, 167, 167, 167),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 8),
            ],
          ),
        ));
  }
}

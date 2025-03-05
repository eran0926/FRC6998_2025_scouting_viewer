import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:viewer/constants.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/chart_legend_widget.dart';

class RadarChartCard extends StatelessWidget {
  final String title;
  final Map<String, double> data;
  final List<String> legends;
  const RadarChartCard(
      {super.key, this.title = '', required this.data, required this.legends});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        title: title,
        aspectRatio: 1.3,
        child: Expanded(
            child: Column(children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: legends.asMap().entries.map((entry) {
          //     final index = entry.key;
          //     final legend = entry.value;
          //     return ChartLegend(
          //       color: chartColorSet[index % chartColorSet.length],
          //       text: legend,
          //       isSquare: false,
          //       size: 16,
          //       textColor: const Color.fromARGB(255, 167, 167, 167),
          //     );
          //   }).toList(),
          // ),
          // SizedBox(height: 8),
          Expanded(
              child: RadarChart(RadarChartData(
            radarShape: RadarShape.polygon,
            dataSets: [
              RadarDataSet(
                dataEntries: data.entries
                    .map((entry) => RadarEntry(value: entry.value))
                    .toList(),
                fillColor: const Color.fromARGB(100, 41, 93, 239),
                borderColor: const Color.fromARGB(255, 41, 93, 239),
              )
            ],
            // borderData: FlBorderData(
            //     show: true,
            //     border: Border.all(
            //         width: 10, color: const Color.fromARGB(255, 255, 44, 44))),
            getTitle: (index, angle) => RadarChartTitle(
                text:
                    '${data.keys.toList()[index]}: ${(data.values.toList()[index] * 100).round() / 100}'),
            radarBackgroundColor: Colors.transparent,
            borderData: FlBorderData(show: false),
            radarBorderData:
                const BorderSide(color: Color.fromARGB(255, 96, 125, 139)),
            titlePositionPercentageOffset: 0.1,
            titleTextStyle: TextStyle(fontSize: 16),
            tickCount: 4,
            // ticksTextStyle: const TextStyle(fontSize: 18),
            tickBorderData:
                const BorderSide(color: Color.fromARGB(255, 96, 125, 139)),
            gridBorderData:
                BorderSide(color: Color.fromARGB(255, 96, 125, 139), width: 2),
          )))
        ])));
  }
}

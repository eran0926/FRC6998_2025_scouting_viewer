import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/indicator.dart';

class PieChartCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final List<Color> colors = [
    Color(0xff003f5c),
    Color(0xff524a83),
    Color(0xffa74780),
    Color(0xffdc5553),
    Color(0xffff7c43),
  ];
  PieChartCard({super.key, this.title = '', required this.data});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: title,
      aspectRatio: 1.3,
      child: Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Indicator(
                    color: item['color'] ?? colors[index % colors.length],
                    text: item['name'],
                    isSquare: false,
                    size: 16,
                    textColor: const Color.fromARGB(255, 167, 167, 167),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  height: constraints.maxHeight,
                  child: PieChart(
                    PieChartData(
                      // borderData: FlBorderData(show: false),
                      // sectionsSpace: 40,
                      // centerSpaceRadius: 40,
                      centerSpaceRadius: 0,
                      sections: data
                          .asMap()
                          .map<int, PieChartSectionData>((index, e) {
                            final value = PieChartSectionData(
                              title: e['value'].toString(),
                              color:
                                  e['color'] ?? colors[index % colors.length],
                              value: e['value'].toDouble(),
                              titleStyle: TextStyle(
                                fontSize: 16,
                              ),
                              radius: constraints.maxHeight / 2,
                            );
                            return MapEntry(index, value);
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

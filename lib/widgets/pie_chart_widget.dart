import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:viewer/widgets/indicator.dart';

class PieChartWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  PieChartWidget({this.title = '', required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF21222D),
        borderRadius: BorderRadius.circular(28),
      ),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Column(
          children: [
            SizedBox(height: 8),
            if (title.isNotEmpty) Text(title, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data
                  .map((e) => Indicator(
                        color: e['color'] ?? Colors.cyan,
                        text: e['name'],
                        isSquare: false,
                        size: 16,
                        textColor: const Color.fromARGB(255, 167, 167, 167),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 20,
              child: LayoutBuilder(
                builder: (context, constraints) => PieChart(
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
                            color: e['color'] ?? Colors.cyan,
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
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

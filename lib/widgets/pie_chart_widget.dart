import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:viewer/widgets/indicator.dart';

class PieChartWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  PieChartWidget({this.title = '', required this.data});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          Spacer(),
          if (title.isNotEmpty) Expanded(child: Text(title)),
          Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data
                  .map((e) => Indicator(
                        color: e['color'],
                        text: e['name'],
                        isSquare: false,
                        size: 16,
                        textColor: const Color.fromARGB(255, 167, 167, 167),
                      ))
                  .toList(),
            ),
          ),
          Spacer(),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
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
                          color: e['color'],
                          value: e['value'].toDouble(),
                          title: '${e['value']}%',
                          radius: 160,
                          titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 167, 167, 167)),
                        );
                        return MapEntry(index, value);
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

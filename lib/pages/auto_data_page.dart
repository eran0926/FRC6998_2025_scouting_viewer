import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/widgets/pie_chart_widget.dart';
import 'package:viewer/widgets/preload_pie_chart_widget.dart';
import 'package:viewer/widgets/selectable_reef_data_table.dart';

class AutoDataPage extends StatelessWidget {
  const AutoDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectiveDataProvider objectiveDataProvider =
        Provider.of<ObjectiveDataProvider>(context);
    if (objectiveDataProvider.state == ObjectiveDataProviderState.fetching) {
      return Center(child: CircularProgressIndicator());
    } else if (objectiveDataProvider.state ==
        ObjectiveDataProviderState.teamUnset) {
      return Center(child: Text('Please select a team'));
    } else if (objectiveDataProvider.state ==
        ObjectiveDataProviderState.teamNotFound) {
      return Center(child: Text('Team not found'));
    } else if (objectiveDataProvider.state ==
        ObjectiveDataProviderState.error) {
      return Center(
          child: Text(
              'An error occurred, status code: ${objectiveDataProvider.statusCode}'));
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: SelectableReefDataTable()),
                if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                  SizedBox(width: 16),
                if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                  Expanded(child: SelectableReefDataTable()),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: PreloadPieChartWidget()),
                if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                  SizedBox(width: 16),
                if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                  Expanded(
                      child: PieChartWidget(data: [
                    {'name': 'A', 'value': 10, 'color': Colors.red},
                    {'name': 'B', 'value': 20, 'color': Colors.green},
                    {'name': 'C', 'value': 30, 'color': Colors.blue},
                    {'name': 'D', 'value': 40, 'color': Colors.yellow},
                  ])),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

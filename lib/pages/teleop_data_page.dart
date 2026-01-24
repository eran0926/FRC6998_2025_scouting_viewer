import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/widgets/bar_card.dart';
import 'package:viewer/widgets/bar_chart_card.dart';
import 'package:viewer/widgets/radar_chart_card.dart';
import 'package:viewer/widgets/table_card.dart';

class TeleopDataPage extends StatelessWidget {
  const TeleopDataPage({super.key});

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
        child: Column(children: [
          GridView.count(
              crossAxisCount:
                  ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 2 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BarChartCard(
                  title: 'Average Coral Count by Level',
                  data: {
                    'L1': [
                      objectiveDataProvider.data['teleop']['reef']['l1']
                          ['average'],
                      objectiveDataProvider.data['teleop']['reef']['l1']
                          ['stability']
                    ],
                    'L2': [
                      objectiveDataProvider.data['teleop']['reef']['l2']
                          ['average'],
                      objectiveDataProvider.data['teleop']['reef']['l2']
                          ['stability']
                    ],
                    'L3': [
                      objectiveDataProvider.data['teleop']['reef']['l3']
                          ['average'],
                      objectiveDataProvider.data['teleop']['reef']['l3']
                          ['stability']
                    ],
                    'L4': [
                      objectiveDataProvider.data['teleop']['reef']['l4']
                          ['average'],
                      objectiveDataProvider.data['teleop']['reef']['l4']
                          ['stability']
                    ],
                  },
                  legends: ['Average', 'Stability'],
                ),
                RadarChartCard(
                  title: 'Z-Score for each Reef Level',
                  data: {
                    'L1': objectiveDataProvider.data['teleop']['reef']['l1']
                                ['z_score'] *
                            10 +
                        50,
                    'L2': objectiveDataProvider.data['teleop']['reef']['l2']
                                ['z_score'] *
                            10 +
                        50,
                    'L3': objectiveDataProvider.data['teleop']['reef']['l3']
                                ['z_score'] *
                            10 +
                        50,
                    'L4': objectiveDataProvider.data['teleop']['reef']['l4']
                                ['z_score'] *
                            10 +
                        50,
                  },
                  minValue: -20,
                  maxValue: 100,
                  tickCount: 6,
                  // isMinValueAtCenter: false,
                ),
                BarChartCard(
                  title: 'Average Algae Count for each Arena Element',
                  data: {
                    'Processor': [
                      objectiveDataProvider.data['teleop']['processor_score']
                          ['average'],
                      objectiveDataProvider.data['teleop']['processor_score']
                          ['stability']
                    ],
                    'Net': [
                      objectiveDataProvider.data['teleop']['net_score']
                          ['average'],
                      objectiveDataProvider.data['teleop']['net_score']
                          ['stability']
                    ],
                  },
                  legends: ['Average', 'Stability'],
                ),
                BarChartCard(
                  title: 'Algae Z-Score for each Arena Element',
                  data: {
                    'Processor': [
                      objectiveDataProvider.data['teleop']['processor_score']
                          ['z_score']
                    ],
                    'Net': [
                      objectiveDataProvider.data['teleop']['net_score']
                          ['z_score']
                    ],
                  },
                  legends: ['Processor', 'Net'],
                  minY: -3,
                  maxY: 3,
                ),
              ]),
          SizedBox(height: 16),
          BarCard(
              title: 'Average Hang Time',
              end: objectiveDataProvider.data['teleop']['hang']['average']),
          SizedBox(height: 16),
          BarCard(
            title: 'Average Hang Stability',
            end: objectiveDataProvider.data['teleop']['hang']['stability'],
            maxY: 5,
          ),
          SizedBox(height: 16),
          BarCard(
            title: 'Average Hang Z-Score',
            end: objectiveDataProvider.data['teleop']['hang']['z_score'],
            minY: -3,
            maxY: 3,
          ),
          SizedBox(height: 16),
          TableCard(title: 'Hang Data', data: {
            'Average Hang Time': objectiveDataProvider.data['teleop']['hang']
                ['average'],
            'Average Hang Stability': objectiveDataProvider.data['teleop']
                ['hang']['stability'],
            'Average Hang Z-Score': objectiveDataProvider.data['teleop']['hang']
                ['z_score'],
          })
        ]),
      ),
    ));
  }
}

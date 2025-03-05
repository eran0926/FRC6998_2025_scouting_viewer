import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/utils/pie_chart_data_transformer.dart';
import 'package:viewer/widgets/bar_chart_card.dart';
import 'package:viewer/widgets/bar_card.dart';
import 'package:viewer/widgets/pie_chart_card.dart';
import 'package:viewer/widgets/radar_chart_card.dart';
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
        child: Column(children: [
          // Row(
          //   children: [
          //     Expanded(child: SelectableReefDataTable()),
          //     if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
          //       SizedBox(width: 16),
          //     if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
          //       Expanded(child: SelectableReefDataTable()),
          //   ],
          // ),
          // SizedBox(height: 16),
          BarCard(
            title: 'Leave Success Rate',
            end: objectiveDataProvider.data['auto']['leave_success_rate'] * 100,
          ),
          SizedBox(height: 16),
          SelectableReefDataTable(),
          SizedBox(height: 16),
          GridView.count(
              crossAxisCount:
                  ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 2 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                PieChartCard(
                    title: 'Preload',
                    data: pieChartDataTransformer(
                        objectiveDataProvider.data['auto']['preload_count'])),
                PieChartCard(
                    title: 'Start Position',
                    data: pieChartDataTransformer(objectiveDataProvider
                        .data['auto']['start_position_count'])),
                BarChartCard(
                  title: "Arena Elements' Scoring",
                  data: {
                    'Reef': [
                      objectiveDataProvider.data['auto']['reef_score']
                          ['average'],
                      objectiveDataProvider.data['auto']['reef_score']
                          ['stability']
                    ],
                    'Processor': [
                      objectiveDataProvider.data['auto']['processor_score']
                          ['average'],
                      objectiveDataProvider.data['auto']['processor_score']
                          ['stability']
                    ],
                    'Net': [
                      objectiveDataProvider.data['auto']['processor_score']
                          ['average'],
                      objectiveDataProvider.data['auto']['processor_score']
                          ['stability']
                    ],
                  },
                  legends: ['Average', 'Stability'],
                ),
                RadarChartCard(
                  title: 'Z-Score for Arena Element',
                  data: {
                    'Reef': objectiveDataProvider.data['auto']['reef_score']
                        ['z_score'],
                    'Processor': objectiveDataProvider.data['auto']
                        ['processor_score']['z_score'],
                    'Net': objectiveDataProvider.data['auto']['net_score']
                        ['z_score'],
                  },
                  tickCount: 3,
                  isMinValueAtCenter: false,
                ),
                BarChartCard(
                  title: "Average Reef Count by Level",
                  data: {
                    'L1': [
                      objectiveDataProvider.data['auto']['reef']['l1']
                          ['average'],
                      objectiveDataProvider.data['auto']['reef']['l1']
                          ['stability']
                    ],
                    'L2': [
                      objectiveDataProvider.data['auto']['reef']['l2']
                          ['average'],
                      objectiveDataProvider.data['auto']['reef']['l2']
                          ['stability']
                    ],
                    'L3': [
                      objectiveDataProvider.data['auto']['reef']['l3']
                          ['average'],
                      objectiveDataProvider.data['auto']['reef']['l3']
                          ['stability']
                    ],
                    'L4': [
                      objectiveDataProvider.data['auto']['reef']['l4']
                          ['average'],
                      objectiveDataProvider.data['auto']['reef']['l4']
                          ['stability']
                    ],
                  },
                  legends: ['Average', 'Stability'],
                ),
                RadarChartCard(
                  title: "Count Z-Score by each Level",
                  data: {
                    'L1': objectiveDataProvider.data['auto']['reef']['l1']
                        ['z_score'],
                    'L2': objectiveDataProvider.data['auto']['reef']['l2']
                        ['z_score'],
                    'L3': objectiveDataProvider.data['auto']['reef']['l3']
                        ['z_score'],
                    'L4': objectiveDataProvider.data['auto']['reef']['l4']
                        ['z_score'],
                  },
                  tickCount: 3,
                  isMinValueAtCenter: false,
                ),
                RadarChartCard(
                  title: "Reef Success Rate by Side",
                  data: {
                    'AB': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['AB'],
                    'CD': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['CD'],
                    'EF': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['EF'],
                    'GH': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['GH'],
                    'IJ': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['IJ'],
                    'KL': objectiveDataProvider.data['auto']
                        ['reef_success_rate_by_side']['KL'],
                  },
                )
              ]),
          // RadarChartCard(
          //   title: "Test",
          //   data: {
          //     "AB": 0,
          //     "BC": 30,
          //     "CD": 40,
          //     "EF": 4.56444444,
          //     "GH": 70,
          //     "IJ": 100,
          //   },
          //   legends: ["A"],
          // )
        ]),
        // SizedBox(height: 16),
      ),
    ));
  }
}

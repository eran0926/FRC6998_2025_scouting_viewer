import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/utils/pie_chart_data_transformer.dart';
import 'package:viewer/widgets/pie_chart_widget.dart';

class PreloadPieChartWidget extends StatelessWidget {
  const PreloadPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectiveDataProvider objectiveDataProvider =
        Provider.of<ObjectiveDataProvider>(context);
    return PieChartWidget(
        title: 'Preload',
        data: pieChartDataTransformer(
            objectiveDataProvider.data['auto']['preload_count']));
  }
}

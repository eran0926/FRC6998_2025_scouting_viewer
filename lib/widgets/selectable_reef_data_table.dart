import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewer/model/reef_data.dart';
import 'package:viewer/providers/objective_data_provider.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/reef_data_table.dart';

class SelectableReefDataTable extends StatefulWidget {
  const SelectableReefDataTable({super.key});

  @override
  State<SelectableReefDataTable> createState() =>
      _SelectableReefDataTableState();
}

class _SelectableReefDataTableState extends State<SelectableReefDataTable> {
  String selectedDataType = 'reef_count_per_point';
  @override
  Widget build(BuildContext context) {
    ObjectiveDataProvider objectiveDataProvider =
        Provider.of<ObjectiveDataProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      double childWidth = max(390, constraints.maxWidth);
      ReefData reefData = ReefData.fromJson(
          objectiveDataProvider.data['auto'][selectedDataType]);
      return CardWidget(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              SizedBox(height: 16),
              DropdownMenu<String>(
                width: childWidth / 1.618,
                initialSelection: 'reef_count_per_point',
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                      value: 'reef_count_per_point',
                      label: 'Reef Count per Point'),
                  // DropdownMenuEntry<String>(
                  //     value: '2', label: 'Reef Success/Tried'),
                  // DropdownMenuEntry<String>(
                  //     value: '2', label: 'Reef Success rate'),
                  // DropdownMenuEntry<String>(
                  //     value: '2', label: 'Reef Position Proportion'),
                ],
                onSelected: (value) =>
                    setState(() => selectedDataType = value ?? ''),
              ),
              SizedBox(height: 16),
              ReefDataTable(
                width: childWidth,
                data: reefData.toTableData(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

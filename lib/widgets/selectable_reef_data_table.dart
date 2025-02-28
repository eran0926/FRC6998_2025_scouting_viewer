import 'dart:math';

import 'package:flutter/material.dart';
import 'package:viewer/widgets/card_widget.dart';
import 'package:viewer/widgets/reef_data_table.dart';

class SelectableReefDataTable extends StatelessWidget {
  const SelectableReefDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double childWidth = max(390, constraints.maxWidth);
      return CardWidget(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              SizedBox(height: 16),
              DropdownMenu<String>(
                width: childWidth / 1.618,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                      value: '1', label: 'Average Reef Success'),
                  DropdownMenuEntry<String>(
                      value: '2', label: 'Reef Success/Tried'),
                  DropdownMenuEntry<String>(
                      value: '2', label: 'Reef Success rate'),
                  DropdownMenuEntry<String>(
                      value: '2', label: 'Reef Position Proportion'),
                ],
              ),
              SizedBox(height: 16),
              ReefDataTable(
                width: childWidth,
                data: {
                  'l4': ['1', '2', '3', '4', '5', '6', '6'],
                  'l3': ['7', '8', '9', '10', '11', '12', '6'],
                  'l2': ['13', '14', '15', '16', '17', '18', '6'],
                  'l1': ['19', '20', '21', '22', '23', '24', '6'],
                  'sum': [
                    '25/34',
                    '26/33',
                    '27/34',
                    '28/34',
                    '29/32',
                    '30/23',
                    '30/23'
                  ],
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

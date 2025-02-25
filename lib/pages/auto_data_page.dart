import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:viewer/widgets/reef_data_table.dart';
import 'package:viewer/widgets/selectable_reef_data_table.dart';

class AutoDataPage extends StatelessWidget {
  const AutoDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(child: SelectableReefDataTable()),
            if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
              SizedBox(width: 16),
            if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
              Expanded(child: SelectableReefDataTable()),
          ],
        ),
      ),
    ));
  }
}

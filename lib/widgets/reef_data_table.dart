import 'package:flutter/material.dart';

class ReefDataTable extends StatelessWidget {
  final double? width;
  final Map<String, List<String>> data;
  final String endTitle;

  const ReefDataTable({
    super.key,
    this.width,
    required this.data,
    this.endTitle = 'SUM',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: [
          _titleRowBuilder(
              data: ['LEVEL', 'AB', 'CD', 'EF', 'GH', 'IJ', 'KL', endTitle]),
          _rowBuilder(title: 'L4', data: data['l4']!),
          _rowBuilder(title: 'L3', data: data['l3']!),
          _rowBuilder(title: 'L2', data: data['l2']!),
          _rowBuilder(title: 'L1', data: data['l1']!),
          _rowBuilder(title: endTitle, data: data['all_level']!),
        ],
      ),
    );
  }
}

_titleRowBuilder({required List<String> data}) {
  return TableRow(
    children: [
      for (var item in data) _cellBuilder(item, isHeader: true),
    ],
  );
}

_rowBuilder({String title = '', required List<String> data}) {
  return TableRow(
    children: [
      _cellBuilder(title, isHeader: true),
      for (var item in data) _cellBuilder(item),
    ],
  );
}

_cellBuilder(String data, {bool isHeader = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
    child: Text(data,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: isHeader ? 17 : 16,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
  );
}

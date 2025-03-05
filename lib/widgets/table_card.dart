import 'package:flutter/material.dart';
import 'package:viewer/widgets/card_widget.dart';

class TableCard extends StatelessWidget {
  final String title;
  final Map<String, double> data;
  const TableCard({super.key, this.title = '', required this.data});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        title: title,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Table(border: TableBorder.all(color: Colors.white), children: [
            TableRow(
              children: data.keys
                  .map((key) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(key,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
            TableRow(
              children: data.values
                  .map((value) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value.toString(),
                            style: TextStyle(color: Colors.white)),
                      ))
                  .toList(),
            ),
          ]),
        ));
  }
}

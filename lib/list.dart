import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeakersQueue>(
      builder: (context, speakers, child) => DataTable(
        columns: _columns,
        rows: List<DataRow>.generate(
            speakers.items.length,
            (i) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(speakers.items[i].nr)),
                    DataCell(Text(speakers.items[i].name)),
                    DataCell(Text(speakers.items[i].info1)),
                    DataCell(Text(speakers.items[i].info2)),
                  ],
                )),
      ),
    );
  }

  static const _colNames = ['Ombudsnummer', 'Namn', 'Utmanarlag', 'Kår'];
  final List<DataColumn> _columns = [
    for (final s in _colNames) DataColumn(label: Text(s))
  ];
}

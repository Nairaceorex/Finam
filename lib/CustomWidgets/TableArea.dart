import 'package:flutter/material.dart';

class TableArea extends StatefulWidget{
  @override
  TableAreaState createState() => TableAreaState();
}
class TableAreaState extends State<TableArea>{
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: [
          DataColumn(label: Text("Name")),

          DataColumn(label: Text("Sum")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text("Tinkoff")),
            DataCell(Text("10000")),
          ]),
          DataRow(cells: [
            DataCell(Text("Alpha")),
            DataCell(Text("354")),
          ]),


        ],
      );

  }
}
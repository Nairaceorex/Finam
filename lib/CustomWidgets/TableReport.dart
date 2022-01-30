import 'package:flutter/material.dart';

class TableReport extends StatefulWidget{
  @override
  TableReportState createState() => TableReportState();
}
class TableReportState extends State<TableReport>{
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Date&Time")),
        DataColumn(label: Text("Operation")),
        DataColumn(label: Text("Sum")),
        DataColumn(label: Text("Area")),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-13:25:15")),
          DataCell(Text("Refill")),
          DataCell(Text("100")),
          DataCell(Text("Tinkoff")),
        ]),
        DataRow(cells: [
          DataCell(Text("2022.1.13-14:18:43")),
          DataCell(Text("Spending")),
          DataCell(Text("355")),
          DataCell(Text("Alpha")),
        ]),
      ],
    );

  }
}
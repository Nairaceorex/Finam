
import 'package:banking/CustomWidgets/TableArea.dart';
import 'package:banking/CustomWidgets/TableReport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormReportState();
}



class FormReportState extends State {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [TableReport()],
        ),
      ),
    );


  }
  Widget _buildTableReport() => Column(
    children: [
      Text("History",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      TableReport(),
    ],
  );
}
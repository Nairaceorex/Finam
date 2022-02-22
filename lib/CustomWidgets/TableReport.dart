import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableReport extends StatefulWidget{
  @override
  TableReportState createState() => TableReportState();
}
class TableReportState extends State<TableReport>{
  final Stream<QuerySnapshot> account =
  FirebaseFirestore.instance.collection('History').where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}").orderBy("date_time", descending: true).snapshots();
//.collection("History")
// .orderBy("date_time", "asc")
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: account,
          builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError) {
              return Text('problem');
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return Text('Loading');
            }
            final data = snapshot.requireData;


            return DataTable(
                columns: [
                  DataColumn(label: Text("Дата/Время")),
                  DataColumn(label: Text("Операция")),
                  DataColumn(label: Text("Сумма")),
                  DataColumn(label: Text("Счёт")),
                ],
                rows: List.generate(data.size, (index) =>

                    buildList(data, index,snapshot))
            );
          }),
      /*DataTable(
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
        )*/
    );


  }
  DataRow buildList(data, g, snapshot) {
    var docs = snapshot.data.docs;
    final acc = docs[g].data()!;
    final f = new DateFormat('yyyy-MM-dd hh:mm');

    return DataRow(cells: [

      DataCell(Text("${acc['date_time'].toDate().toString().substring(0,16)}")),
      DataCell(Text("${acc['operation']}")),
      DataCell(Text("${acc['summary']}")),
      DataCell(Text("${acc['account']}")),

    ]);

  }

}
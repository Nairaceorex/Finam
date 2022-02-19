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
  FirebaseFirestore.instance.collection('History').where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}").snapshots();

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

            /*int sIze = 1;
            for(int i=0; i != data.size; i++){
              if(data.docs[i]['user_uid'] == FirebaseAuth.instance.currentUser!.uid){
                sIze+=1;
              }
              else{
                continue;
              }
            }*/
            return DataTable(
                columns: [
                  DataColumn(label: Text("Date&Time")),
                  DataColumn(label: Text("Operation")),
                  DataColumn(label: Text("Sum")),
                  DataColumn(label: Text("Account")),
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
    /*DataTable(
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
    );*/

  }
  DataRow buildList(data, g, snapshot) {
    var docs = snapshot.data.docs;
    final acc = docs[g].data()!;
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    //var date = DateTime.fromMicrosecondsSinceEpoch(miliseconds * 1000);
   // DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(date.toUtc());
    /*List<String> wasd = <String>[];
    for(int i=0; i < wasd.length; i++){
      wasd.insert(i, acc['summary'].toString());
    }*/
    //print(wasd.runtimeType);
    //print("${acc['name'].runtimeType}");
    //wasd.clear();

    //wasd.insert(wasd.length, acc['summary'].toString());
    /*print(wasd.length);
    print(wasd);*/
    /*for(int i=0; i < wasd.length; i++){
      print(wasd[i]);
    }*/
    return DataRow(cells: [
//f.format(new DateTime.fromMillisecondsSinceEpoch(acc['date_time']*1000))
    //${acc['date_time'].toDate()}
      DataCell(Text("${acc['date_time'].toDate().toString().substring(0,16)}")),
      DataCell(Text("${acc['operation']}")),
      DataCell(Text("${acc['summary']}")),
      DataCell(Text("${acc['account']}")),

    ]);
    /*if (acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid){
      return DataRow(cells: [
      DataCell(Text(acc['name'])),
      DataCell(Text("${acc['summary']}")),
    ]);
    }
    else{
      print('error');
    }
*/
    /*return DataRow(
        cells: [
          DataCell(
            Container(
              width: 25,
            )
          ),
          DataCell(
              Container(
                width: 25,
              )
          )
        ]);*/

    /*return DataRow(cells: [
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? acc['name']: null)
      ),
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? "${acc['summary']}" : "")
      ),
    ]);*/
    /*return DataRow(cells: [
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? acc['name']: "")
      ),
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? "${acc['summary']}" : "")
      ),
    ]);*/
    /*return DataRow(cells: [
      DataCell(Text(data.docs[i]['name'])),
      DataCell(Text("${data.docs[i]['summary']}")),
    ]);*/
  }

}
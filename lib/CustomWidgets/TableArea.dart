import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TableArea extends StatefulWidget{
  @override
  TableAreaState createState() => TableAreaState();
}
class TableAreaState extends State<TableArea>{
  final Stream<QuerySnapshot> account =
      FirebaseFirestore.instance.collection('Account').where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}").snapshots();
  //Query<Map<String, dynamic>> _account = FirebaseFirestore.instance.collection('Account')
      //.where('${FirebaseAuth.instance.currentUser!.uid}');

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
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Summary')),
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

      DataCell(Text(acc['name'])),
      DataCell(Text("${acc['summary']}")),

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TableArea extends StatefulWidget{
  @override
  TableAreaState createState() => TableAreaState();
}
class TableAreaState extends State<TableArea>{
  final Stream<QuerySnapshot> account =
  FirebaseFirestore.instance.collection('Account').where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}").orderBy("name", descending: false).snapshots();
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
                  DataColumn(label: Text('Название')),
                  DataColumn(label: Text('Сумма')),
                ],
                rows: List.generate(data.size, (index) =>

                    buildList(data, index,snapshot))
            );
          }),

    );
  }
  DataRow buildList(data, g, snapshot) {
    var docs = snapshot.data.docs;
    final acc = docs[g].data()!;

    return DataRow(cells: [

      DataCell(Text(acc['name'])),
      DataCell(Text("${acc['summary']}")),

    ]);

  }
}
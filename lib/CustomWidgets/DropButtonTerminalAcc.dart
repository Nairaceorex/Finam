import 'package:banking/domain/AccList.dart';
import 'package:banking/domain/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DropButtonTerminalAcc extends StatefulWidget {
  const DropButtonTerminalAcc({Key? key}) : super(key: key);

  @override
  State<DropButtonTerminalAcc> createState() => _DropButtonTerminalAccState();
}

class _DropButtonTerminalAccState extends State<DropButtonTerminalAcc> {
  String? dropdownValue;

  Stream<QuerySnapshot> db =
  FirebaseFirestore.instance.collection('Account')
      .where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
      .snapshots();
  String? title;
  List<String> arr = <String>[];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: db,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('problem');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            final data = snapshot.requireData;
            
            return DropdownButton<String>(
              hint: Text('Acc'),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: getDocData(data, data.size, snapshot)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }),

    );
  }
  List<String> getDocData(data, g, snapshot) {

    var docs = snapshot.data.docs;
   /* var doc = docs[g-1];
    final acc = doc.data();*/

    List<String> wasd = <String>[];

    for(int i=0; i < g; i++){
      var doc = docs[i];
      final acc = doc.data();
      wasd.insert(i, acc['name'].toString());
      /*print(wasd[i]);
      print(i);*/
    }
    return wasd;
    //print(wasd);
    /*Query<Map<String, dynamic>> _cat =
    FirebaseFirestore.instance.collection('Account')
        .where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}");
    Query query = _cat.where("name", isEqualTo: "qwe");
    QuerySnapshot querySnapshot = await query.get();
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return _docData[1];*/
  }
  /*List<String> buildList(data, i, snapshot) {
    var docs = snapshot.data.docs;
    final acc = docs[i].data()!;
    final items = [];
    for(var acc in acc){

    }
    return List;
  }*/
}
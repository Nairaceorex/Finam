import 'package:banking/CustomWidgets/DropButtonTerminalAcc.dart';
import 'package:banking/CustomWidgets/DropButtonTerminalOper.dart';
import 'package:banking/CustomWidgets/TableReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormTerminal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormTerminalState();
}

class FormTerminalState extends State {
  final _formKey = GlobalKey<FormState>();

  var _summary = 0;

  Stream<QuerySnapshot> _operationDrop =
      FirebaseFirestore.instance.collection('Operation').snapshots();
  String? dropdownValueOper;
  var _oper;

  Stream<QuerySnapshot> _accountDrop = FirebaseFirestore.instance
      .collection('Account')
      .where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
      .snapshots();
  String? dropdownValueAcc;
  var _acc;

  Widget buildDporOper() => Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _operationDrop,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('problem');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              final data = snapshot.requireData;

              return DropdownButtonFormField<String>(
                hint: Text('Oper'),
                value: dropdownValueOper,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                /*underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),*/
                onChanged: (String? newValue) {
                  _oper = newValue;
                  print(_oper);
                  setState(() {
                    dropdownValueOper = newValue!;
                  });
                },
                validator: (newValue){
                  if (newValue == null || newValue.isEmpty){
                    return "Select operation";
                  }
                },
                items: getDocDataOper(data, data.size, snapshot)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
      );

  List<String> getDocDataOper(data, g, snapshot) {
    var docs = snapshot.data.docs;
    /* var doc = docs[g-1];
    final acc = doc.data();*/

    List<String> wasd = <String>[];

    for (int i = 0; i < g; i++) {
      var doc = docs[i];
      final acc = doc.data();
      wasd.insert(i, acc['Type'].toString());
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

  Widget buildDporAcc() => Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _accountDrop,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('problem');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              final data = snapshot.requireData;

              return DropdownButtonFormField<String>(
                hint: Text('Acc'),
                value: dropdownValueAcc,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                /*underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),*/
                onChanged: (String? newValue) {
                  _acc = newValue;

                  print(_acc);
                  setState(() {
                    dropdownValueAcc = newValue;
                  });
                },
                validator: (newValue){
                  if (newValue == null || newValue.isEmpty){
                    return "Select account";
                  }
                },
                items: getDocDataAcc(data, data.size, snapshot)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
      );

  List<String> getDocDataAcc(data, g, snapshot) {
    var docs = snapshot.data.docs;
    /* var doc = docs[g-1];
    final acc = doc.data();*/

    List<String> wasd = <String>[];

    for (int i = 0; i < g; i++) {
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(10.0),
                child: Form(
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          'Сумма',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        new TextFormField(onChanged: (value) {
                          _summary = int.parse(value);
                          print(_summary);
                        }, validator: (value) {
                          if (value!.isEmpty) return 'Пожалуйста введите число';
                          String num = "[0-9]";
                          RegExp regExp = new RegExp(num);
                          if (regExp.hasMatch(value)) return null;
                          return 'Используйте числа';
                        }),
                        new SizedBox(height: 20.0),
                        new Text(
                          'Операция',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildDporOper(),
                        ),
                        new SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildDporAcc(),
                        ),
                        new SizedBox(height: 20.0),
                        _button("Add", _acc, _summary, _oper),
                        /*ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate())
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Операция успешно выполнена'),
                            backgroundColor: Colors.green,
                          )
                      );
                  },
                    child: Text('Выполнить'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                  ),*/
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  Widget _button(String text, var name, var sum, var oper) {
    CollectionReference _history =
        FirebaseFirestore.instance.collection('History');

    return ElevatedButton(
      onPressed: () {
        // Переходим к новому маршруту
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Операция успешно выполнена'),
            backgroundColor: Colors.green,
          ));
          print(name);
          print(sum);
          print(oper);
          _history.add({
            'account': name,
            'summary': sum,
            'operation': oper,
            "date_time": Timestamp.now(),
            'user_uid': FirebaseAuth.instance.currentUser!.uid
          });
          //Navigator.push(context, MaterialPageRoute(builder: (context) => TableReport()));
        }
        //_formKey.currentState!.reset();

      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }
}

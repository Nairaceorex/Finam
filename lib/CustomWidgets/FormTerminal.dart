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

  List<String> accId = <String>[];
  var id = 0;

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
                hint: Text('Операция'),
                value: dropdownValueOper,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),

                onChanged: (String? newValue) {
                  _oper = newValue;
                  print(_oper);
                  setState(() {
                    dropdownValueOper = newValue!;
                  });
                },
                validator: (newValue){
                  if (newValue == null || newValue.isEmpty){
                    return "Операция";
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


    List<String> wasd = <String>[];

    for (int i = 0; i < g; i++) {
      var doc = docs[i];
      final acc = doc.data();
      wasd.insert(i, acc['Type'].toString());

    }
    return wasd;

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
              accId = getDocDataAccId(data, data.size, snapshot);


              return DropdownButtonFormField<String>(
                hint: Text('Счёт'),
                value: dropdownValueAcc,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),

                onChanged: (String? newValue) {
                  _acc = newValue;
                 id = getDocDataAcc(data, data.size, snapshot).indexOf(_acc);
                  print(id);
                  print(accId[id]);
                  print(_acc);
                  setState(() {
                    dropdownValueAcc = newValue;
                  });
                },
                validator: (newValue){
                  if (newValue == null || newValue.isEmpty){
                    return "Счёт";
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


    List<String> wasd = <String>[];

    for (int i = 0; i < g; i++) {
      var doc = docs[i];
      final acc = doc.data();
      wasd.insert(i, acc['name'].toString());

    }
    return wasd;

  }

  List<String> getDocDataAccId(data, g, snapshot) {
    var docs = snapshot.data.docs;


    List<String> wasd = <String>[];

    for (int i = 0; i < g; i++) {
      var doc = docs[i];
      final acc = doc.data();
      wasd.insert(i, acc['doc_id'].toString());

    }
    return wasd;

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
                        new Text(
                          'Счёт',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildDporAcc(),
                        ),
                        new SizedBox(height: 20.0),
                        _button("Выполнить", _acc, _summary, _oper),

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
      onPressed: () async {
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
          CollectionReference accs = FirebaseFirestore.instance.collection('Account');
          QuerySnapshot allRes = await accs.where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
              .where("name", isEqualTo: "${name}").get();
          allRes.docs.forEach((DocumentSnapshot res) {
            print(res.id);
            print(res.data());
            int summ = res['summary'];
            accs.doc('${res.id}')
            .update({
              'summary': summ - sum
            });
          });
        }
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountFormState();

}
class AccountFormState extends State<AccountForm>{
  final _fornKey = GlobalKey<FormState>();
  var name = '';
  var sum = 0;

  @override
  Widget build(BuildContext context) {
    CollectionReference account = FirebaseFirestore.instance.collection('Account');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _fornKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.subtitles),
                          labelText: "Счёт"
                      ),
                      onChanged: (value){
                        name = value;
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "Название";
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          labelText: "Сумма"
                      ),
                      onChanged: (value){
                        sum = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "Сумма";
                        }
                      },
                    ),
      ElevatedButton(
        onPressed: () async {
          CollectionReference accs = FirebaseFirestore.instance.collection('Account');
          QuerySnapshot allRes = await accs.where("user_uid", isEqualTo: "${FirebaseAuth.instance.currentUser!.uid}")
              .get();
          List<String> Name = <String>[];
          for (DocumentSnapshot res in allRes.docs){
            Name.add(res['name']);
          }
          print(Name);
          // Переходим к новому маршруту
          if(((_fornKey.currentState!.validate()) && ((Name.contains(name)) && (name != null)))==false){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Счёт успешно добавлен'),
                  backgroundColor: Colors.green,
                )
            );
            //print(name);
            //print(sum);
            account.add({
              'name': name,
              'summary': sum,
              'user_uid':FirebaseAuth.instance.currentUser!.uid,
              'id_doc': account.doc().id,
            }).
            then((value) => print("acc added")).
            catchError((error) => print("Error: $error"));
            Navigator.pop(context);
          }
          if(((_fornKey.currentState!.validate()) && ((Name.contains(name)) && (name != null)))==true){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Счёт уже существует'),
                  backgroundColor: Colors.red,
                )
            );
          }
        },
        child: Text("Добавить"),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent, // background
          onPrimary: Colors.white, // foreground
        ),
      ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
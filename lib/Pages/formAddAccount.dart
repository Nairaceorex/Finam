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
                          return "enter name";
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
                          return "enter sum";
                        }
                      },
                    ),
      ElevatedButton(
        onPressed: (){
          // Переходим к новому маршруту
          if(_fornKey.currentState!.validate()){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Счёт успешно добавлен'),
                  backgroundColor: Colors.green,
                )
            );
            print(name);
            print(sum);
            account.add({
              'name': name,
              'summary': sum,
              'user_uid':FirebaseAuth.instance.currentUser!.uid }).
            then((value) => print("acc added")).
            catchError((error) => print("Error: $error"));

          }
          Navigator.pop(context);
        },
        child: Text("Add"),
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
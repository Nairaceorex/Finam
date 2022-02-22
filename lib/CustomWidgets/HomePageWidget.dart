import 'package:banking/CustomWidgets/DropButtonTerminalAcc.dart';
import 'package:banking/CustomWidgets/EditButton.dart';
import 'package:banking/CustomWidgets/TableArea.dart';
import 'package:banking/CustomWidgets/TableReport.dart';
//import 'package:banking/Models/User.dart';
import 'package:banking/Pages/ReportPage.dart';
import 'package:banking/Pages/formAddAccount.dart';
import 'package:banking/domain/account.dart';
import 'package:banking/domain/users.dart';
import 'package:banking/services/database.dart';
//import 'package:banking/utils/UserPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageWidgetState();
  }
}
enum OperationList { plus, minus }
class HomePageWidgetState extends State<HomePageWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _accountnameController = TextEditingController();
  TextEditingController _accountsummaryController = TextEditingController();
  var _accountname;
  var _accountsummary;
  //Account account = Account();


  @override
  Widget build(BuildContext context) {
    //final user = UserPref.myUser;
    CollectionReference _account = FirebaseFirestore.instance.collection('Account');

    return Scaffold(
        body: Center(
          child: ListView(
            children: [
              const SizedBox(height: 24),
              //  buildName("joe"),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              buildArea(),

            ],
          ),
        )
    );
  }


  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Добавить счёт',
    onClicked: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => _redAcc()));
    },
  );

  Widget buildArea() => Column(
    children: [

      Text('Счета', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      TableArea()
    ],
  );

  /* Widget buildName(User user) => Column(
    children: [

      Text(
        user.login,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),

      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );*/

  Widget _redAcc() {
    return AccountForm();

  }

  Widget _button(String text, var name, var sum){
    CollectionReference _account = FirebaseFirestore.instance.collection('Account');

    return ElevatedButton(
      onPressed: (){
        // Переходим к новому маршруту
        if(_formKey.currentState!.validate()){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Счёт успешно добавлен'),
                backgroundColor: Colors.green,
              )
          );
          print(name);
          print(sum);
          _account.add({'name': name, 'summary': sum, 'user_uid':FirebaseAuth.instance.currentUser!.uid });

        }
        Navigator.pop(context);
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }

}


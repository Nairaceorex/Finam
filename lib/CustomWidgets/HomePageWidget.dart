import 'package:banking/CustomWidgets/DropButtonTerminalAcc.dart';
import 'package:banking/CustomWidgets/EditButton.dart';
import 'package:banking/CustomWidgets/TableArea.dart';
import 'package:banking/CustomWidgets/TableReport.dart';
import 'package:banking/Models/User.dart';
import 'package:banking/Pages/formAddAccount.dart';
import 'package:banking/domain/account.dart';
import 'package:banking/domain/users.dart';
import 'package:banking/services/database.dart';
import 'package:banking/utils/UserPref.dart';
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
 /* void _buttonAction() async{
    _accountname = _accountnameController.text;
    _accountsummary = _accountsummaryController;

    await DatabaseService().addOrUpdateAccount(account);

    _accountnameController.clear();
    _accountsummaryController.clear();


  }*/

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Добавить счёт',
    onClicked: () {
      _showFullModal(context);
    },
  );

  Widget buildArea() => Column(
    children: [

      Text('Area', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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

  _showFullModal(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Modal", // label for barrier
      transitionDuration: Duration(milliseconds: 500), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) { // your widget implementation
        return Scaffold(
          appBar: AppBar(
              //backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
              title: Text(
                "Добавить счёт",
                style: TextStyle(color: Colors.white, fontFamily: 'Overpass', fontSize: 20),
              ),
              elevation: 0.0,

          ),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Center(
            child: ListView(
              children: [
                //AccountForm()
                //_form("Добавить",_buttonAction),
                Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(

                              style: TextStyle(fontSize: 20,color: Colors.pink),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle( fontSize: 20, color: Colors.pink),
                                  hintText: "Acc",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pink, width: 3)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 1)
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 30),
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.pinkAccent),
                                      child: Icon(Icons.account_balance_wallet),
                                    ),

                                  )
                              ),
                              onChanged: (value){
                                _accountname=value;
                              },
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return 'null';
                                }
                              },
                            ),
                          )//child: Text("Email"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(

                              style: TextStyle(fontSize: 20,color: Colors.pink),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle( fontSize: 20, color: Colors.pink),
                                  hintText: "sum",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pink, width: 3)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 1)
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 30),
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.pinkAccent),
                                      child: Icon(Icons.account_balance_wallet),
                                    ),

                                  )
                              ),
                              onChanged: (value){
                                _accountsummary=int.parse(value);
                              },
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return 'null';
                                }
                              },
                            ),
                          ),
                          //child: Text("Email"),
                        ),


                        SizedBox(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: _button("Add",_accountname,_accountsummary),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }

  /*Widget _form(String label, void func()){
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.account_balance_wallet),"Счёт", _accountnameController,false),
            //child: Text("Email"),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.monetization_on),"Сумма", _accountsummaryController,false),
            //child: Text("Email"),
          ),


          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(
                left: 20, right: 20
            ),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label,func),
            ),
          )
        ],
      ),
    );
  }*/

  /*Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20,color: Colors.pink),
        decoration: InputDecoration(
            hintStyle: TextStyle( fontSize: 20, color: Colors.pink),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink, width: 3)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent, width: 1)
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 30),
              child: IconTheme(
                data: IconThemeData(color: Colors.pinkAccent),
                child: icon,
              ),

            )
        ),

      ),
    );
  }*/

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
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }

  }


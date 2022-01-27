import 'package:banking/CustomWidgets/DropButtonTerminal.dart';
import 'package:banking/CustomWidgets/EditButton.dart';
import 'package:banking/CustomWidgets/TableArea.dart';
import 'package:banking/CustomWidgets/TableReport.dart';
import 'package:banking/Models/User.dart';
import 'package:banking/utils/UserPref.dart';
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
  //GenderList? _gender = GenderList.male;
  OperationList? _operation;
  @override
  Widget build(BuildContext context) {
    final user = UserPref.myUser;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 24),
            buildName(user),
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
    text: 'Edit profile',
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

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      Text(
        user.login,
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

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
                "Modal",
                style: TextStyle(color: Colors.white, fontFamily: 'Overpass', fontSize: 20),
              ),
              elevation: 0.0
          ),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Center(
            child: ListView(
              children: [
                Form(
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[
                        new Text('Сумма', style: TextStyle(fontSize: 20.0),),
                        new TextFormField(validator: (value){
                          if (value!.isEmpty) return 'Пожалуйста введите число';
                          String num = "[0-9]";
                          RegExp regExp = new RegExp(num);
                          if(regExp.hasMatch(value)) return null;
                          return 'Используйте числа';
                        }

                        ),
                        new SizedBox(height: 20.0),
                        new Text('Операция', style: TextStyle(fontSize: 20.0),),
                        RadioListTile<OperationList>(
                          title: const Text('Прибавить'),
                          value: OperationList.plus,
                          groupValue: _operation,
                          onChanged: (OperationList? value){
                            setState(() {
                              _operation = value;
                            });
                          },
                        ),
                        RadioListTile<OperationList>(
                          title: const Text('Вычесть'),
                          value: OperationList.minus,
                          groupValue: _operation,
                          onChanged: (OperationList? value){
                            setState(() {
                              _operation = value;
                            });
                          },
                        ),
                        new SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DropButtonTerminal(),
                        ),


                        new SizedBox(height: 20.0),

                        new ElevatedButton(onPressed: (){
                          if(_formKey.currentState!.validate())
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Форма успешно заполнена'),
                                  backgroundColor: Colors.green,
                                )
                            );
                        },
                          child: Text('Проверить'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent, // background
                            onPrimary: Colors.white, // foreground
                          ),
                        ),

                      ],
                    )
                )
              ],
            ),
          )
        );
      },
    );
  }

  }


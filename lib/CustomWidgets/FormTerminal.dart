import 'package:banking/CustomWidgets/DropButtonTerminalAcc.dart';
import 'package:banking/CustomWidgets/DropButtonTerminalOper.dart';
import 'package:flutter/material.dart';

class FormTerminal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormTerminalState();
}

enum OperationList { plus, minus }

class FormTerminalState extends State {
  final _formKey = GlobalKey<FormState>();
  //GenderList? _gender = GenderList.male;
  OperationList? _operation;

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
                  new Text('Сумма', style: TextStyle(fontSize: 20.0),),
                  new TextFormField(
                      validator: (value){
                        if (value!.isEmpty) return 'Пожалуйста введите число';
                        String num = "[0-9]";
                        RegExp regExp = new RegExp(num);
                        if(regExp.hasMatch(value)) return null;
                        return 'Используйте числа';
                  }

                  ),
                  new SizedBox(height: 20.0),
                  new Text('Операция', style: TextStyle(fontSize: 20.0),),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropButtonTerminalOper(),
                  ),

                  new SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropButtonTerminalAcc(),
                  ),


                  new SizedBox(height: 20.0),

                  new ElevatedButton(onPressed: (){
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
                  ),

                ],
              )
          )
      ),
          ],
        ),
      ),
    );

  }
}
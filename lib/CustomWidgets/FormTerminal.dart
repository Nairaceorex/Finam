import 'package:banking/CustomWidgets/DropButtonTerminal.dart';
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
      ),
          ],
        ),
      ),
    );

  }
}
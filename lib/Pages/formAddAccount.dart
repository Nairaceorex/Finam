import 'package:flutter/material.dart';

class AccountForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountFormState();

}
class AccountFormState extends State<AccountForm>{
  final _fornKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          icon: Icon(Icons.account_balance_wallet),
                          labelText: "Счёт"
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
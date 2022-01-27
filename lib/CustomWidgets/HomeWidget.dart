import 'package:banking/CustomWidgets/CustomBottomMenu.dart';
import 'package:banking/Pages/HomePage.dart';
import 'package:banking/Pages/ReportPage.dart';
import 'package:banking/Pages/TerminalPage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }

}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget _myContacts = HomePage();
  Widget _myEmails = TerminalPage();
  Widget _myProfile = ReportPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finam"),
      ),
      body:  this.getBody(),
      bottomNavigationBar: CustomBottomMenu(
        selectedIndex: selectedIndex,
        callback: (newIndex) => setState(
              () => this.selectedIndex = newIndex,
        ),
      ),

    );
  }

  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._myContacts;
    } else if(this.selectedIndex==1) {
      return this._myEmails;
    } else {
      return this._myProfile;
    }
  }


}
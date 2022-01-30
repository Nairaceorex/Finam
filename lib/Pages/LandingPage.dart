
import 'package:banking/CustomWidgets/HomeWidget.dart';
import 'package:banking/Pages/AuthPage.dart';
import 'package:banking/Pages/HomePage.dart';
import 'package:flutter/material.dart';

class LandindPage extends StatelessWidget{

  const LandindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = true;

    return isLoggedIn ? MyHomePage() : AuthPage();
  }
}
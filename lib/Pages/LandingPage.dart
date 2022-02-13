
import 'package:banking/CustomWidgets/HomeWidget.dart';
import 'package:banking/Pages/AuthPage.dart';
import 'package:banking/Pages/HomePage.dart';
import 'package:banking/domain/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandindPage extends StatelessWidget{

  const LandindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users? user = Provider.of<Users?>(context);
    final bool isLoggedIn = user != null;

    return isLoggedIn ? MyHomePage() : AuthPage();
  }
}
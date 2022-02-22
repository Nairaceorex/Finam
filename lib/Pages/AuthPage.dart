import 'package:banking/CustomWidgets/HomeWidget.dart';
import 'package:banking/Pages/HomePage.dart';
import 'package:banking/Pages/LandingPage.dart';
import 'package:banking/domain/users.dart';
import 'package:banking/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget{
  AuthPage({Key? key}) : super(key: key);



  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Padding(

        padding: EdgeInsets.only(top:100),
        child: Container(
          child: Align(
            child: Text(
                "FINAM",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight:FontWeight.bold,
                  color: Colors.white
                )
            ),
          ),
        ),

      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20,color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 30),
              child: IconTheme(
                data: IconThemeData(color: Colors.white,),
                child: icon,
              ),

            )
          ),
        ),
      );
    }

    Widget _button(String text, void func()){
      return ElevatedButton(
        onPressed: (){
          // Переходим к новому маршруту
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyHomePage();
          }));*/
        func();
      },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent, // background
          onPrimary: Colors.white, // foreground
        ),
      );
    }

    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(Icon(Icons.email),"Почта", _emailController,false),
              //child: Text("Email"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock),"Пароль", _passwordController,true),
              //child: Text("Password"),
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
    }

    void _loginButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email!.isEmpty || _password!.isEmpty) return;
      
      Users? user = await _authService.signWithEmailPassword(_email!.trim(), _password!.trim());
      if(user == null){
        Fluttertoast.showToast(
            msg: "Неверный логин или пароль!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email!.isEmpty || _password!.isEmpty) return;

      Users? user = await _authService.registerWithEmailPassword(_email!.trim(), _password!.trim());
      if(user == null){
        Fluttertoast.showToast(
            msg: "Регистрация не удалась",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [Column(
          children: <Widget>[
            _logo(),
            (
              showLogin ? Column(
                children: <Widget>[
                  _form("Войти",_loginButtonAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text("Нет учетной записи?\nЗарегистрируйтесь!", style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onTap:(){
                        setState((){
                          showLogin = false;

                    });
                    },
                    ),
                  )
                ]
              )
              : Column(
                  children: <Widget>[
                    _form("Регистрация",_registerButtonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text("Есть учетная запись?", style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap:(){
                          setState((){
                            showLogin = true;
                          });
                        },
                      ),
                    )
                  ]
              )
            ),


          ],
        )],
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String? id;

  Users.fromFirebase(User user){
    id = user.uid;
  }
}
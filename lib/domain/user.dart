import 'package:firebase_auth/firebase_auth.dart';

class UseR {
  String? id;

  UseR.fromFirebase(User user){
    id = user.uid;
  }
}
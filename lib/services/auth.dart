import 'package:banking/domain/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  Future<Users?> signWithEmailPassword(String email, String password) async{
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Users.fromFirebase(user!);
    }catch(e){
      print(e);
      return null;
    }
  }
  Future<Users?> registerWithEmailPassword(String email, String password) async{
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Users.fromFirebase(user!);
    }catch(e){
      print(e);
      return null;
    }
  }
  Future logOut() async{
    await _fAuth.signOut();
  }
  Stream<Users?> get currentUser{
    return _fAuth.authStateChanges()
        .map((User? user) => user != null ? Users.fromFirebase(user) : null);
  }
}
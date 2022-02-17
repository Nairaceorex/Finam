import 'package:banking/domain/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference _accountCollection = FirebaseFirestore.instance.collection('Account');
  final CollectionReference _historyCollection = FirebaseFirestore.instance.collection('History');
  final CollectionReference _areaCollection = FirebaseFirestore.instance.collection('Area');
  final CollectionReference _operationCollection = FirebaseFirestore.instance.collection('Operation');

  Future addOrUpdateAccount(Account account)async{
    return await _accountCollection.doc(account.uid).set(account);
  }
}
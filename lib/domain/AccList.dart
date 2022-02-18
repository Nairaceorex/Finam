import 'package:banking/domain/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

CollectionReference merchRef = _firestore.collection('Account');


Future<List<Account>> getAllMerchants() async {
  List<Account> accList = [];

  await merchRef.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Account acc = Account.fromMap({
        'name': doc['name'],
      });
      accList.add(acc);
    });
  });

  return accList;
}
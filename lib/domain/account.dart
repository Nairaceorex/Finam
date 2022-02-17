class Account{
  String? uid;
  String? name;
  int? summary;

  Account([this.uid,this.name, this.summary]);

  Account.fromJson(String uid, Map<String, dynamic> data){
    uid = uid;
    name = data['name'];
    summary = data['summary'];
  }
}
class Account{
  String? uid;
  String? name;
  int? summary;

  Account({
    this.uid,
    this.name,
    this.summary
});
  Account.fromMap(Map<String, dynamic> map){
    uid = map['user_uid'];
    name = map['name'];
    summary = map['summary'];
  }
  }

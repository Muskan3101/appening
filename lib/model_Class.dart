class Users{
  var name;
  var job;

  Users({this.name, this.job});

  //Factory Constructor
factory Users.fromJson(Map<String, dynamic> map){
  return Users(name: map["name"], job: map["job"]);
}
}
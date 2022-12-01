class Users {
  var id;
  var email;
  var first_name;
  var last_name;
  var avatar;

  Users({
    this.id,
    this.email,
    this.first_name,
    this.last_name,
    this.avatar,
  }); //Factory Constructor
  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
      id: map["id"],
      email: map["email"],
      first_name: map["first_name"],
      last_name: map["last_name"],
      avatar: map["avatar"],
    );
  }
}

class UserModel {
  String uid;
  String name; //full name
  String phone;
  String email;
  String username;
  String password;
  String dp;
  String type;
  DateTime date;

  UserModel(
      {this.uid,
      this.name,
      this.phone,
      this.date,
      this.dp,
      this.email,
      this.username,
      this.password,
      this.type});

  UserModel.fromMap(Map<String, dynamic> userDocument)
      : uid = userDocument['uid'],
        name = userDocument['name'],
        phone = userDocument['phone'],
        dp = userDocument['dp'],
        date = userDocument['date'].toDate(),
        email = userDocument['email'],
        username = userDocument['username'],
        type = userDocument['type'],
        password = userDocument['password'];
}

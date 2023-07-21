import 'dart:convert';

class User {
  int? id;
  String email;
  String name;
  String password;

  User(
      {this.id,
      required this.email,
      required this.name,
      required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "email": email,
      "name": name,
      "password": password
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map["id"],
        email: map["email"],
        name: map["name"],
        password: map["password"]);
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

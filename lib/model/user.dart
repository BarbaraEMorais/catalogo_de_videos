import 'dart:convert';

class User {
  int? id;
  String username;
  String password;

  // required obriga a passar o parametro
  User({this.id, required this.username, required this.password});

  // pega usuario e retorna objeto map dele
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      "username": username,
      "password": password
    };
  }

  // factory primeiro executa o que ta dentro, antes de criar a instancia. um construtor estático
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      // se map["id"] existir, retorna o map["id"]
      id: map["id"],
      username: map["username"],
      password: map["password"]
    );
  }

  // pega usuario e retorna json dele
  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String source) => 
    User.fromMap(jsonDecode(
      source) as Map<String, dynamic>
    );
  
}
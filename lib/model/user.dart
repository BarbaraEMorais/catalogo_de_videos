import 'dart:convert';

class User {
  int? id;
  String email;
  String name;
  String password;

  // required obriga a passar o parametro
  User({this.id,required this.email , required this.name, required this.password});

  // pega usuario e retorna objeto map dele
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      "email": email,
      "name": name,
      "password": password
    };
  }

  // factory primeiro executa o que ta dentro, antes de criar a instancia. um construtor estático
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      // se map["id"] existir, retorna o map["id"]
      id: map["id"],
      email: map["email"],
      name: map["name"],
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
class Genre {
  int? id;
  String name;

  Genre({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
    };
  }

  // factory primeiro executa o que ta dentro, antes de criar a instancia. um construtor estÃ¡tico
  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      // se map["id"] existir, retorna o map["id"]
      id: map["id"],
      name: map["name"],
    );
  }
}
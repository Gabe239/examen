import 'dart:convert';

class Categoria {
  Categoria({
    required this.id,
    required this.name,
    required this.state,
  });

  int id;
  String name;
  String state;

  factory Categoria.fromJson(String str) =>
      Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json["category_id"],
        name: json["category_name"],
        state: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": id,
        "category_name": name,
        "category_state": state,
      };

  static List<Categoria> fromJsonList(List<dynamic> list) {
    return list.map((item) => Categoria.fromMap(item)).toList();
  }
}
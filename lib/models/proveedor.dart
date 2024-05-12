import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.id,
    required this.name,
    required this.lastName,
    required this.mail,
    required this.state,
  });

  int id;
  String name;
  String lastName;
  String mail;
  String state;

  factory Proveedor.fromJson(String str) =>
      Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        id: json["providerid"],
        name: json["provider_name"],
        lastName: json["provider_last_name"],
        mail: json["provider_mail"],
        state: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": id,
        "provider_name": name,
        "provider_last_name": lastName,
        "provider_mail": mail,
        "provider_state": state,
      };

  static List<Proveedor> fromJsonList(List<dynamic> list) {
    return list.map((item) => Proveedor.fromMap(item)).toList();
  }
}
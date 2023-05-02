import 'dart:convert';

//Ingredient Model comes from back-end model
List<DatabaseIngredient> DatabaseIngredientFromJson(String str) =>
    List<DatabaseIngredient>.from(
        json.decode(str).map((x) => DatabaseIngredient.fromJson(x)));

String DatabaseIngredientToJson(List<DatabaseIngredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatabaseIngredient {
  DatabaseIngredient({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory DatabaseIngredient.fromJson(Map<String, dynamic> json) =>
      DatabaseIngredient(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }
}

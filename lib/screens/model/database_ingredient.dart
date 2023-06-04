// To parse this JSON data, do
//
//     final databaseIngredient = databaseIngredientFromJson(jsonString);

import 'dart:convert';

DatabaseIngredient databaseIngredientFromJson(String str) =>
    DatabaseIngredient.fromJson(json.decode(str));

String databaseIngredientToJson(DatabaseIngredient data) =>
    json.encode(data.toJson());

class DatabaseIngredient {
  String? name;
  int? id;

  DatabaseIngredient({
    this.name,
    this.id,
  });

  factory DatabaseIngredient.fromJson(Map<String, dynamic> json) =>
      DatabaseIngredient(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };

  @override
  String toString() {
    return "name: " + name! + "id: " + id.toString();
  }
}





// import 'dart:convert';

// //Ingredient Model comes from back-end model
// List<DatabaseIngredient> DatabaseIngredientFromJson(String str) =>
//     List<DatabaseIngredient>.from(
//         json.decode(str).map((x) => DatabaseIngredient.fromJson(x)));

// // String DatabaseIngredientToJson(List<DatabaseIngredient> data) =>
// //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class DatabaseIngredient {
//   DatabaseIngredient({
//     required this.id,
//     required this.name,
//   });

//   int id;
//   String name;

//   // factory DatabaseIngredient.fromJson(Map<String, dynamic> json) =>
//   //     DatabaseIngredient(
//   //       id: json["id"],
//   //       name: json["name"],
//   //     );
//   factory DatabaseIngredient.fromJson(Map<String, dynamic> map) {
//     return DatabaseIngredient(
//       id: map['id'] != null ? map['id'] : null,
//       name: map['name'] != null ? map['name'] : null,
//     );
//   }
//   @override
//   String toString() {
//     return name;
//   }
// }

// To parse this JSON data, do
//
//     final MenuIngredient = MenuIngredientFromJson(jsonString);

import 'dart:convert';

List<MenuIngredient> MenuIngredientFromJson(String str) =>
    List<MenuIngredient>.from(
        json.decode(str).map((x) => MenuIngredient.fromJson(x)));

String MenuIngredientToJson(List<MenuIngredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuIngredient {
  String title;
  String imageUrl;
  List<String> ingredients;
  bool isMealHidden;
  double price;

  MenuIngredient({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.isMealHidden,
    required this.price,
  });

  factory MenuIngredient.fromJson(Map<String, dynamic> json) => MenuIngredient(
        title: json["title"],
        imageUrl: json["imageURL"],
        isMealHidden: json["isMealHidden"],
        price: json["price"],
        ingredients: List<String>.from(json["MenuIngredients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imageURL": imageUrl,
        "isMealHidden": isMealHidden,
        "price": price,
        "MenuIngredients": List<dynamic>.from(ingredients.map((x) => x)),
      };
}

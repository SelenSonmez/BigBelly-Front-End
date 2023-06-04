// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  int? id;
  String? amount;
  String? amountType;
  String name;
  int? grams;
  Ingredient({
    this.id,
    this.amount,
    this.amountType,
    required this.name,
    this.grams,
  });

  Ingredient copyWith({
    int? id,
    String? amount,
    String? amountType,
    String? name,
    int? grams,
  }) {
    return Ingredient(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      amountType: amountType ?? this.amountType,
      name: name ?? this.name,
      grams: grams ?? this.grams,
    );
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
        amount: map["amount"],
        amountType: map["unit"],
        grams: map["gram"],
        name: map["ingredient_name"]);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'amountType': amountType,
      'name': name,
      'grams': grams,
    };
  }

  // factory Ingredient.fromMap(Map<String, dynamic> map) {
  //   return Ingredient(
  //     id: map['id'] as int,
  //     amount: map['amount'] != null ? map['amount'] as String : null,
  //     amountType:
  //         map['amountType'] != null ? map['amountType'] as String : null,
  //     name: map['name'] as String,
  //     grams: map['grams'] != null ? map['grams'] as double : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ingredient(id: $id, amount: $amount, amountType: $amountType, name: $name, grams: $grams)';
  }

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.amountType == amountType &&
        other.name == name &&
        other.grams == grams;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        amountType.hashCode ^
        name.hashCode ^
        grams.hashCode;
  }
}

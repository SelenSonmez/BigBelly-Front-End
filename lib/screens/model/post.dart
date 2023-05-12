// import 'dart:convert';

// import 'package:bigbelly/screens/model/bigbelly_post_tag.dart';
// import 'package:bigbelly/screens/model/ingredient.dart';

// import '../add_post/widgets/step_tile.dart';
// import '../authentication/model/user_model.dart';
// // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../add_post/widgets/step_tile.dart';
import '../authentication/model/user_model.dart';
import 'bigbelly_post_tag.dart';
import 'ingredient.dart';

class Post {
  int? id;
  String? title;
  String? imageURL;
  String? difficulty;
  String? portion;
  String? preparationTime;
  String? bakingTime;
  List<StepTile>? steps;
  String? description;
  List<Ingredient>? ingredients;
  List<BigBellyPostTag>? tags;
  User? owner;
  Post({
    this.id,
    this.title,
    this.imageURL,
    this.difficulty,
    this.portion,
    this.preparationTime,
    this.bakingTime,
    this.steps,
    this.description,
    this.ingredients,
    this.tags,
    this.owner,
  });

  Post copyWith(
      {int? id,
      String? title,
      String? imageURL,
      String? difficulty,
      String? portion,
      String? preparationTime,
      String? bakingTime,
      List<StepTile>? steps,
      String? description,
      List<Ingredient>? ingredients,
      List<BigBellyPostTag>? tags,
      User? owner}) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      imageURL: imageURL ?? this.imageURL,
      difficulty: difficulty ?? this.difficulty,
      portion: portion ?? this.portion,
      preparationTime: preparationTime ?? this.preparationTime,
      bakingTime: bakingTime ?? this.bakingTime,
      steps: steps ?? this.steps,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      tags: tags ?? this.tags,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageURL': imageURL,
      'difficulty': difficulty,
      'portion': portion,
      'preparationTime': preparationTime,
      'bakingTime': bakingTime,
      'steps': steps!.map((x) => x.toMap()).toList(),
      'description': description,
      'ingredients': ingredients!.map((x) => x.toMap()).toList(),
      'tags': tags!.map((x) => x.toMap()).toList(),
      'owner': owner!.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      difficulty:
          map['difficulty'] != null ? map['difficulty'] as String : null,
      portion:
          map['portion'] != null ? map['portion'].toString() as String : null,
      preparationTime: map['preparationTime'] != null
          ? map['preparationTime'] as String
          : null,
      bakingTime:
          map['bakingTime'] != null ? map['bakingTime'] as String : null,
      steps: map['steps'] != null
          ? List<StepTile>.from(
              (map['steps'] as List<int>).map<StepTile?>(
                (x) => StepTile.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              (map['ingredients'] as List<int>).map<Ingredient?>(
                (x) => Ingredient.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      tags: map['tags'] != null
          ? List<BigBellyPostTag>.from(
              (map['tags'] as List<int>).map<BigBellyPostTag?>(
                (x) => BigBellyPostTag.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      owner: map["owner"] == null ? null : User.fromJson(map["owner"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id,title: $title, imageURL: $imageURL, difficulty: $difficulty, portion: $portion, preparationTime: $preparationTime, bakingTime: $bakingTime, steps: $steps, description: $description, ingredients: $ingredients, tags: $tags)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageURL == imageURL &&
        other.difficulty == difficulty &&
        other.portion == portion &&
        other.preparationTime == preparationTime &&
        other.bakingTime == bakingTime &&
        listEquals(other.steps, steps) &&
        other.description == description &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageURL.hashCode ^
        difficulty.hashCode ^
        portion.hashCode ^
        preparationTime.hashCode ^
        bakingTime.hashCode ^
        steps.hashCode ^
        description.hashCode ^
        ingredients.hashCode ^
        tags.hashCode;
  }
}

// List<Post> postFromJson(String str) =>
//     List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// String postToJson(List<Post> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Post {
//   int? id;
//   String? title;
//   String? imageURL;
//   String? difficulty;
//   String? portion;
//   String? preparationTime;
//   String? bakingTime;
//   List<StepTile>? steps;
//   List<Ingredient>? ingredients;
//   String? description;
//   List<BigBellyPostTag>? tags;
//   User? owner;

//   Post({
//     this.id,
//     this.title,
//     this.imageURL,
//     this.difficulty,
//     this.portion,
//     this.preparationTime,
//     this.bakingTime,
//     this.steps,
//     this.ingredients,
//     this.description,
//     this.tags,
//     this.owner,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["id"],
//         title: json["title"],
//         imageURL: json["imageURL"],
//         difficulty: json["difficulty"],
//         portion: json["portion"],
//         preparationTime: json["preparationTime"],
//         bakingTime: json["bakingTime"],
//         steps: json["steps"] == null
//             ? []
//             : List<StepTile>.from(json["steps"]!.map((x) => x)),
//         ingredients: json["ingredients"] == null
//             ? []
//             : List<Ingredient>.from(json["ingredients"]!.map((x) => x)),
//         description: json["description"],
//         tags: json["tags"] == null
//             ? []
//             : List<BigBellyPostTag>.from(json["tags"]!.map((x) => x)),
//         owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "imageURL": imageURL,
//         "difficulty": difficulty,
//         "portion": portion,
//         "preparationTime": preparationTime,
//         "bakingTime": bakingTime,
//         "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
//         "ingredients": ingredients == null
//             ? []
//             : List<dynamic>.from(ingredients!.map((x) => x)),
//         "description": description,
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//         "owner": owner?.toJson(),
//       };
// }


// import 'dart:convert';

// import 'package:bigbelly/screens/model/bigbelly_post_tag.dart';
// import 'package:bigbelly/screens/model/ingredient.dart';

// import '../add_post/widgets/step_tile.dart';
// import '../authentication/model/user_model.dart';
// // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

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
  String? preparation_time;
  String? baking_time;
  List<StepTile>? steps;
  String? description;
  List<Ingredient>? ingredients;
  List<BigBellyPostTag>? tags;
  User? account;
  List<dynamic>? likes;
  int likeCount;
  int commentCount;
  bool? isLiked;
  String? dateCreated;
  Post({
    this.id,
    this.title,
    this.imageURL,
    this.difficulty,
    this.portion,
    this.preparation_time,
    this.baking_time,
    this.steps,
    this.description,
    this.ingredients,
    this.tags,
    required this.likeCount,
    required this.commentCount,
    this.account,
    this.likes,
    this.dateCreated,
    this.isLiked,
  });

  Post copyWith(
      {int? id,
      String? title,
      String? imageURL,
      String? difficulty,
      String? portion,
      String? preparation_time,
      String? baking_time,
      List<StepTile>? steps,
      String? description,
      List<Ingredient>? ingredients,
      List<BigBellyPostTag>? tags,
      User? account,
      String? dateCreated}) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      imageURL: imageURL ?? this.imageURL,
      difficulty: difficulty ?? this.difficulty,
      portion: portion ?? this.portion,
      preparation_time: preparation_time ?? this.preparation_time,
      baking_time: baking_time ?? this.baking_time,
      likeCount: likeCount,
      commentCount: commentCount,
      steps: steps ?? this.steps,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      tags: tags ?? this.tags,
      account: account ?? this.account,
      likes: likes ?? this.likes,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageURL': imageURL,
      'difficulty': difficulty,
      'portion': portion,
      'preparation_time': preparation_time,
      'baking_time': baking_time,
      'steps': steps!.map((x) => x.toMap()).toList(),
      'description': description,
      'ingredients': ingredients!.map((x) => x.toMap()).toList(),
      'tags': tags!.map((x) => x.toMap()).toList(),
      'likes': likes!.map((x) => x.toMap()).toList(),
      'account': account!.map((x) => x.toMap()).toList(),
      'dateCreated': dateCreated
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
      preparation_time: map['preparation_time'] != null
          ? map['preparation_time'] as String
          : null,
      baking_time:
          map['baking_time'] != null ? map['baking_time'] as String : null,
      steps: map['steps'] != null
          ? List<StepTile>.from(
              (map['steps'] as List<dynamic>).map<StepTile?>(
                (x) => StepTile.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              (map['ingredients'] as List<dynamic>).map<Ingredient?>(
                (x) => Ingredient.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      tags: map['tags'] != null
          ? List<BigBellyPostTag>.from(
              (map['tags'] as List<dynamic>).map<BigBellyPostTag?>(
                (x) => BigBellyPostTag.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      account: map["account"] == null ? null : User.fromJson(map["account"]),
      likes: map["likes"] == null ? null : map['likes'],
      isLiked: false,
      likeCount: map["likes"] == null ? 0 : map['likes'].length,
      commentCount: map["comments"] == null ? 0 : map['comments'].length,
      dateCreated:
          map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id,title: $title, imageURL: $imageURL, difficulty: $difficulty, portion: $portion, preparation_time: $preparation_time, baking_time: $baking_time, steps: $steps, description: $description, ingredients: $ingredients, tags: $tags, account: $account, created_at:$dateCreated, likes: $likes, isLiked: $isLiked)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageURL == imageURL &&
        other.difficulty == difficulty &&
        other.portion == portion &&
        other.preparation_time == preparation_time &&
        other.baking_time == baking_time &&
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
        preparation_time.hashCode ^
        baking_time.hashCode ^
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
//   String? preparation_time;
//   String? baking_time;
//   List<StepTile>? steps;
//   List<Ingredient>? ingredients;
//   String? description;
//   List<BigBellyPostTag>? tags;
//   User? account;

//   Post({
//     this.id,
//     this.title,
//     this.imageURL,
//     this.difficulty,
//     this.portion,
//     this.preparation_time,
//     this.baking_time,
//     this.steps,
//     this.ingredients,
//     this.description,
//     this.tags,
//     this.account,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["id"],
//         title: json["title"],
//         imageURL: json["imageURL"],
//         difficulty: json["difficulty"],
//         portion: json["portion"],
//         preparation_time: json["preparation_time"],
//         baking_time: json["baking_time"],
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
//         account: json["account"] == null ? null : User.fromJson(json["account"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "imageURL": imageURL,
//         "difficulty": difficulty,
//         "portion": portion,
//         "preparation_time": preparation_time,
//         "baking_time": baking_time,
//         "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
//         "ingredients": ingredients == null
//             ? []
//             : List<dynamic>.from(ingredients!.map((x) => x)),
//         "description": description,
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//         "account": account?.toJson(),
//       };
// }


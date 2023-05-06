// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../add_post/widgets/step_tile.dart';
import 'bigbelly_post_tag.dart';
import 'ingredient.dart';

class Post {
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
  Post({
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
  });

  Post copyWith({
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
  }) {
    return Post(
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] != null ? map['title'] as String : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      difficulty:
          map['difficulty'] != null ? map['difficulty'] as String : null,
      portion: map['portion'] != null ? map['portion'] as String : null,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(title: $title, imageURL: $imageURL, difficulty: $difficulty, portion: $portion, preparationTime: $preparationTime, bakingTime: $bakingTime, steps: $steps, description: $description, ingredients: $ingredients, tags: $tags)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.title == title &&
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
    return title.hashCode ^
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

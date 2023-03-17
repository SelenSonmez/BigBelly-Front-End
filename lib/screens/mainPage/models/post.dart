// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.postId,
    this.postTitle,
  });

  int postId;
  String? postTitle;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json["postID"],
        postTitle: json["postTitle"],
      );

  Map<String, dynamic> toJson() => {
        "postID": postId,
        "postTitle": postTitle,
      };
}

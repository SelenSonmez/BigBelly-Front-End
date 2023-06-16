import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/model/post.dart';

final postListProvider = StateProvider<PostListModel>((ref) {
  return PostListModel();
});

class PostListModel extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get getPost => _posts;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  Post? getPostByID(int id) {
    for (Post post in _posts) {
      if (post.id == id) {
        return post;
      }
    }
    return null;
  }

  void editPost(Post post, int index) {
    _posts[index] = post;
    notifyListeners();
  }

  void setPost(List<Post> post) {
    _posts = post;

    notifyListeners();
  }

  // set setTitle(String title) {
  //   _posts.title = title;

  //   notifyListeners();
  // }
}

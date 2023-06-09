import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/model/post.dart';

final postProvider = StateProvider<PostModel>((ref) {
  return PostModel();
});

class PostModel extends ChangeNotifier {
  Post _post = Post(steps: [], tags: [], ingredients: []);

  Post get getPost => _post;

  void setPost(Post post) {
    _post = post;

    notifyListeners();
  }

  set setTitle(String title) {
    _post.title = title;

    notifyListeners();
  }
}

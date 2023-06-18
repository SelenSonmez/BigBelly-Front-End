import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/model/post.dart';

final groupStateProvider = StateProvider<GroupState>((ref) {
  return GroupState();
});

class GroupState extends ChangeNotifier {
  Post recommendationPost = Post(commentCount: 0, likeCount: 0);

  set setRecommendationPost(Post post) {
    recommendationPost = post;
    notifyListeners();
  }

  Post get getPost => recommendationPost;
}

import 'package:bigbelly/screens/mainPage/data/post_api_client.dart';

import '../locator.dart';
import '../models/post.dart';

class PostRepository {
  PostApiClient postApiClient = locator<PostApiClient>();

  Future<Post> getPost(int postId) async {
    return Post(postId: 2); //to be filled
  }
}

import 'dart:convert';

import 'package:bigbelly/constants/providers/currentUser_provider.dart';
import 'package:bigbelly/constants/providers/postList_provider.dart';
import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'authentication/model/user_model.dart';
import 'imports.dart';
import 'mainPage/main_page_imports.dart';
import 'model/post.dart';
import 'post_details/post_details.dart';

class PostListView extends ConsumerStatefulWidget {
  PostListView({super.key, this.postsDeneme});
  List<Post>? postsDeneme = [];
  @override
  ConsumerState<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends ConsumerState<PostListView> {
  int postCount = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  Future<void> fetchPosts() async {
    var posts = ref.read(postListProvider);
    dynamic id = await SessionManager().get('id');
    final response =
        await dio.get('/profile/$id/home-page-posts?take=1&skip=$postCount');

    var postsJson = response.data['payload']['posts'];
    List<Post> itemsList = List.from(postsJson.map((i) {
      Post post = Post.fromJson(jsonEncode(i));
      post.account!.privacySetting!.isPrivate =
          i['account']['privacy_setting']['is_private'];
      return post;
    }));
    for (var element in itemsList) {
      posts.addPost(element);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchPosts();
  }

  getID() async {
    dynamic id = await SessionManager().get("id");
    return id;
  }

  @override
  Widget build(BuildContext context) {
    var posts = ref.watch(postListProvider);
    // var post = ref.watch(postProvider);
    var userID = ref.watch(userIDProvider);
    var id = getID();
    return Scaffold(
        body: Center(
            child: ListView.builder(
      controller: _scrollController,
      itemCount:
          _isLoadingMore ? posts.getPost.length + 1 : posts.getPost.length,
      itemBuilder: (context, index) {
        if (index < posts.getPost.length) {
          Post post = posts.getPost[index];
          post.likes!.forEach((element) {
            if (element["account_id"] == userID.getUserID) {
              post.isLiked = true;
              posts.editPost(post, index);
            }
          });
          post.imageURL = "http://18.184.145.252/post/${post.id!}/image";
          return Column(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetails(
                        post: post,
                        index: index,
                      ),
                    ));
              },
              child: Image.network(
                post.imageURL!,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    PostitleAndTags(post: post),
                    PostOwnerAndDate(hideUsername: false, post: post),
                    postReactions(
                      post: post,
                      index: index,
                    ),
                    const Divider(thickness: 2)
                  ],
                )),
            index == posts.getPost.length - 1
                ? const SizedBox(
                    height: 30,
                  )
                : const SizedBox()
          ]);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }

  Future<void> _scrollListener() async {
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLoadingMore = true;
      });
      postCount = postCount + 1;

      await fetchPosts();
      setState(() {
        _isLoadingMore = false;
      });
    } else {}
  }
}

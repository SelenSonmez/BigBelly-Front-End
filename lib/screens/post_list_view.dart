import 'dart:convert';

import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'authentication/model/user_model.dart';
import 'imports.dart';
import 'mainPage/main_page_imports.dart';
import 'model/post.dart';
import 'post_details/post_details.dart';

class PostListView extends ConsumerWidget {
  PostListView({super.key});

  Future<List<Post>> getPosts() async {
    dynamic id = await SessionManager().get('id');
    final response = await dio.get('/profile/$id/posts');
    var postsJson = response.data['payload']['posts'];
    // var dene = response.data['payload']['posts'][1]['account']['username'];
    // print(postsJson);
    List<Post> itemsList =
        List.from(postsJson.map((i) => Post.fromJson(jsonEncode(i))));

    print("-------------------------");
    print(postsJson);
    print("-------------------------");

    return itemsList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var post = ref.watch(postProvider);
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Post>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var postTemp = snapshot.data![index];
                post.setPost(postTemp);
                post.getPost.imageURL =
                    "http://18.184.145.252/post/${post.getPost.id!}/image";
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostDetails(postID: post.getPost.id!),
                          ));
                    },
                    child: Image.network(
                      post.getPost.imageURL!,
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
                          PostitleAndTags(),
                          PostOwnerAndDate(),
                          postReactions(),
                          Divider(thickness: 2)
                        ],
                      )),
                  index == snapshot.data!.length - 1
                      ? const SizedBox(
                          height: 55,
                        )
                      : const SizedBox()
                ]);
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}

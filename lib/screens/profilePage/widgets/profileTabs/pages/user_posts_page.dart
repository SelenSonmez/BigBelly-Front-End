import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:bigbelly/screens/post_list_view.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../model/post.dart';

class UserPosts extends ConsumerStatefulWidget {
  const UserPosts({super.key});

  @override
  ConsumerState<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends ConsumerState<UserPosts> {
  late List<Post> itemsList;
  @override
  void initState() {
    super.initState();
  }

  Future<List<Post>> getPosts([UserModel? user]) async {
    debugPrint("user posts metot geldi");

    dynamic id = await SessionManager().get('id');
    final response = await dio.get('/profile/$id/posts');
    var postsJson = response.data['payload']['posts'];
    // List<Post> itemsList = postFromJson(postsJson);
    itemsList = List.from(postsJson.map((i) => Post.fromJson(jsonEncode(i))));

    user!.setPostCount(itemsList.length);
    ProfileInfo();
    //debugPrint(postsJson);
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("user posts geldi");
    UserModel user = ref.watch(userProvider);
    return Center(
      child: FutureBuilder<List<Post>>(
          future: getPosts(user),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                      child: GestureDetector(
                        onTap: () {},

                        child: Image.network(
                          "http://18.184.145.252/post/${snapshot.data![index].id!}/image",
                          fit: BoxFit.contain,
                        ),

                        // child: Text(snapshot.data![index].title!))
                      ));
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}

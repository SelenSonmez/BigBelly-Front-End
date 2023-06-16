import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:bigbelly/screens/post_list_view.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_info.dart';
import 'package:bigbelly/screens/profile_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../authentication/model/user_model.dart';
import '../../../../model/post.dart';

class UserPosts extends ConsumerStatefulWidget {
  UserPosts({super.key, this.isUserSelf = false});
  bool isUserSelf;
  @override
  ConsumerState<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends ConsumerState<UserPosts> {
  List<Post> itemsList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Post>> getPosts([UserModel? user]) async {
    dynamic id = await SessionManager().get('id');
    final response = await dio.get('/profile/${user!.getUser.id}/posts');
    var postsJson = response.data['payload']['posts'];
    List<Post> institutionalPosts = [];

    for (var element in postsJson) {
      Post post = Post.fromJson(jsonEncode(element));
      if (element['institutional_post'] == null) {
        itemsList.add(post);
      }
      post.account = User.fromJson(response.data['payload']['account']);
    }

    user.setPostCount(itemsList.length);
    const ProfileInfo();
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
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
                  String imageURL =
                      "http://18.184.145.252/post/${snapshot.data![index].id!}/image";
                  return Container(
                      margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileListView(
                                        profilePosts: itemsList,
                                        isUserSelf: widget.isUserSelf)));
                          },
                          child: Center(
                              child: Image.network(imageURL,
                                  fit: BoxFit.contain))));
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}

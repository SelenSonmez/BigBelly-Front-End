import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../model/post.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => _UserPostsState();
}

Future<List<Post>> getPosts() async {
  dynamic id = await SessionManager().get('id');
  final response = await dio.get('/profile/$id/posts');
  var postsJson = response.data['payload']['posts'];
  // List<Post> itemsList = postFromJson(postsJson);
  List<Post> itemsList =
      List.from(postsJson.map((i) => Post.fromJson(jsonEncode(i))));
  print(itemsList);
  return itemsList;
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Post>>(
          future: getPosts(),
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => MainPage(
                                  // postIndexToBeShown: index,
                                  // isVisible: false,
                                  ))),
                        ),
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

import 'dart:convert';

import 'package:bigbelly/constants/dio.dart';
import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../authentication/model/user_model.dart';
import '../../../../model/post.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  Future<List<Post>> getPosts() async {
    dynamic id = await SessionManager().get('id');

    final response =
        await dio.get("/post/get-recipes", data: {'account_id': id});
    var postsJson = response.data['payload']['posts'];
    List<Post> posts = List.from(postsJson.map((i) {
      Post post = Post.fromJson(jsonEncode(i['post']));
      // post.account = User.fromJson(response.data['payload']['account']);
      return post;
    }));
    print("----------recipes.dart------------");
    print(posts);
    print("---------recipes.dart-------------");

    return posts;
  }

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
                  snapshot.data![index].imageURL =
                      "http://18.184.145.252/post/${snapshot.data![index].id!}/image";

                  return Stack(
                    children: [
                      Container(
                          child: Center(
                              child: Image.network(
                                  snapshot.data![index].imageURL!,
                                  fit: BoxFit.contain))),
                      Positioned(
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.red.shade400.withOpacity(0.8),
                          foregroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.only(left: 0),
                            icon: Icon(Icons.remove),
                            onPressed: () async {
                              print("Geldi");
                              dynamic id = await SessionManager().get("id");
                              final response = await dio.post(
                                  "/post/${snapshot.data![index].id!}/derecipe",
                                  data: {'account_id': id});
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text("Post Removed From Re-cipes")));
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}

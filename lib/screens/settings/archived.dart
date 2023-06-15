import 'dart:convert';

import 'package:bigbelly/screens/imports.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../model/post.dart';

class ArchivedRecipes extends StatefulWidget {
  ArchivedRecipes({super.key});

  @override
  State<ArchivedRecipes> createState() => _ArchivedRecipesState();
}

class _ArchivedRecipesState extends State<ArchivedRecipes> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Post>> getPosts() async {
    dynamic id = await SessionManager().get('id');
    Map<String, dynamic> params = <String, dynamic>{
      'account_id': id,
    };

    final response = await dio.get("/post/get-archiveds", data: params);
    var postsJson = response.data['payload']['posts'];
    print(postsJson);
    List<Post> posts = List.from(postsJson.map((i) {
      Post post = Post.fromJson(jsonEncode(i));
      // post.account = User.fromJson(response.data['payload']['account']);
      return post;
    }));
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return Scaffold(
        appBar: AppBar(title: Text("Archived Recipe")),
        body: Center(
          child: FutureBuilder<List<Post>>(
              future: getPosts(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      // print(snapshot.data![index].id!);
                      String imageURL =
                          "http://18.184.145.252/post/${snapshot.data![index].id!}/image";
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("AA");
                                },
                                child:
                                    Image.network(imageURL, fit: BoxFit.fill)),
                            Positioned(
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor:
                                    Colors.red.shade400.withOpacity(0.8),
                                foregroundColor: Colors.white,
                                child: IconButton(
                                  padding: EdgeInsets.only(left: 0),
                                  icon: Icon(Icons.remove),
                                  onPressed: () async {
                                    print("Geldi");
                                    final response = await dio.post(
                                        "/post/${snapshot.data![index].id!}/dearchive");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Post Removed From Archives")));
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                            // IconButton(
                            //     onPressed: () async {
                            //       print("GELDDDDDD");
                            //       final response = await dio.post(
                            //           "/post/${snapshot.data![index].id!}/dearchive");
                            //       print(response.data);
                            //       setState(() {});
                            //     },
                            //     icon: Icon(Icons.remove_circle_outline,
                            //         color: Colors.red))
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
        ));
  }
}

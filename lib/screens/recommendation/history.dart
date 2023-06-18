import 'dart:convert';

import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/recommendation/texts.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../authentication/model/user_model.dart';
import '../model/post.dart';
import '../post_details/post_details.dart';
import 'recommendation_screen.dart';

class History extends StatelessWidget {
  History({super.key});
  List<Post> itemsList = [];

  Future<List<Post>> recommendationHistory() async {
    dynamic id = await SessionManager().get("id");

    final response =
        await dio.get("/recommendation/history", data: {'account_id': id});

    var postsJson = response.data['payload']['posts'];

    itemsList = List.from(postsJson.map((i) {
      logger.i(i);
      Post post = Post.fromJson(jsonEncode(i["post"]));
      post.account!.username = i['post']['account']['username'];
      post.imageURL = "http://18.184.145.252/post/${post.id!}/image";
      return post;
    }));
    logger.i(itemsList);
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    recommendationHistory();
    return Scaffold(
      appBar: AppBar(
        title: Text(RecHistory),
      ),
      body: Center(
        child: FutureBuilder(
          future: recommendationHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  Post post = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
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
                      child: Card(
                          elevation: 12,
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size(70, 80),
                                  child: Image.network(post.imageURL!,
                                      fit: BoxFit.cover),
                                )),
                            title: Text(post.title!),
                            subtitle: Text(post.account!.username!),
                          )),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

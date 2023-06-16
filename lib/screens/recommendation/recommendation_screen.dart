import 'dart:convert';

import 'package:bigbelly/constants/dio.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:bigbelly/screens/recommendation/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../authentication/model/user_model.dart';
import '../model/post.dart';

class RecommendationScreen extends StatefulWidget {
  RecommendationScreen({Key? key}) : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  Post post = Post(likeCount: 0, commentCount: 0);
  bool isChecked = false;
  List<User> users = [];
  Future<Post> getRecommendation() async {
    dynamic id = await SessionManager().get("id");
    final response =
        await dio.get("/recommendation/", data: {'account_id': id});

    print(response.data);
    post = Post.fromJson(jsonEncode(response.data['payload']['post']));
    post.imageURL = "http://18.184.145.252/post/${post.id!}/image";
    print("--------------------------");
    print(post.likeCount);
    print("--------------------------");
    setState(() {});

    return post;
  }

  Future<List<User>> getFollowers() async {
    dynamic id = await SessionManager().get("id");
    final response = await dio.get("/profile/$id/followers");

    var usersJson = response.data['payload']['followers'];
    print(usersJson);
    // users = List.from(usersJson.map((i) {
    //   User user = User.fromJson(i);
    //   print("AAAA" + user.username!);
    //   return user;
    // }));
    return users;
  }

  @override
  void initState() {
    getFollowers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Recommendation),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 75, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      RecommendationHistory),
                  Container(
                      // padding: EdgeInsets.only(left: 25),
                      child: Text(
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          SeeAll))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PostDetails(post: post, index: post.id!),
                    ));
              },
              child: Card(
                elevation: 25,
                color: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 350,
                  height: 175,
                  child: Center(child: FutureBuilder(
                    // future: getRecommendation(),
                    builder: (context, snapshot) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20), // Image border
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(50), // Image radius
                                      child: post.title == null
                                          ? Image.network(
                                              'https://images.unsplash.com/photo-1565976469782-7c92daebc42e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                                              fit: BoxFit.cover)
                                          : Card(
                                              elevation: 17,
                                              child: Image.network(
                                                  post.imageURL!)),
                                    ),
                                  ),
                                ),
                                //Likes
                                Container(
                                    child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                        color: Colors.white,
                                        size: 22,
                                        Icons.thumb_up_alt),
                                    Text(
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                        post.title != null
                                            ? post.likeCount.toString()
                                            : "")
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //Recipe Title
                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Colors.white),
                                      post.title != null
                                          ? post.title!
                                          : "Old Recommendation Title"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      "${By} ${post.title != null ? "post.account!.username!" : "Old Recommendation"}"),
                                ],
                              ))
                        ],
                      );
                    },
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(GetRecommendation,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      dynamic id = await SessionManager().get("id");
                      final response =
                          await dio.get("/recommendation?account_id=$id");
                      print(response.data);
                      getRecommendation();
                    },
                    child: Text(ForSelf)),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Scaffold(
                                    floatingActionButton: FloatingActionButton(
                                      backgroundColor: Colors.green.shade700,
                                      onPressed: () {},
                                      child: Text("Get"),
                                    ),
                                    floatingActionButtonLocation:
                                        FloatingActionButtonLocation.miniEndTop,
                                    appBar: AppBar(title: Text("Add Friends")),
                                    body: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(15),
                                          // height: 70,
                                          // width: 350,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    radius: 27.0,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green.shade300,
                                                      backgroundImage: AssetImage(
                                                          "assets/images/yesilSef.jpg"),
                                                      radius: 25.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Post.account",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Checkbox(
                                                      value: isChecked,
                                                      onChanged: (bool? value) {
                                                        print(isChecked
                                                            .toString());
                                                        setState(() {
                                                          isChecked = value!;
                                                        });
                                                      })
                                                ],
                                              ),
                                              Divider(
                                                thickness: 2,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            onClosing: () {},
                          );
                        },
                      );
                    },
                    child: Text(ForGroup)),
              ],
            )
          ],
        )));
  }
}

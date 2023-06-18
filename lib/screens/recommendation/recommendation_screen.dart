import 'dart:convert';

import 'package:bigbelly/constants/dio.dart';
import 'package:bigbelly/constants/providers/group_state_provider.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:bigbelly/screens/recommendation/history.dart';
import 'package:bigbelly/screens/recommendation/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import '../authentication/model/user_model.dart';
import '../model/post.dart';

var logger = Logger();

class RecommendationScreen extends ConsumerStatefulWidget {
  RecommendationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecommendationScreen> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen> {
  // Post post = Post(likeCount: 0, commentCount: 0);
  bool isChecked = false;
  List<User> users = [];
  List checkboxes = [];

  getRecommendation(var post) async {
    dynamic id = await SessionManager().get("id");
    final response =
        await dio.get("/recommendation/", data: {'account_id': id});
    if (response.data["success"] == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(ThereIsNoInfo),
      ));
    } else {
      post.setRecommendationPost =
          Post.fromJson(jsonEncode(response.data['payload']['post']));
      post.getPost.imageURL =
          "http://18.184.145.252/post/${post.getPost.id!}/image";

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(Recommended),
      ));
    }

    setState(() {});
  }

  Future<List<User>> getFollowers() async {
    dynamic id = await SessionManager().get("id");
    dynamic username = await SessionManager().get("username");
    final response = await dio.get("/profile/$id/followeds");

    var usersJson = response.data['payload']['followeds'];

    users = List.from(usersJson.map((i) {
      User user = User.fromJson(i['followed_account']);
      // user.username = i['']
      return user;
    }));
    // logger.i(users);
    checkboxes.add({
      'id': 0,
      'username': username + " (Self)",
      'account_id': id,
      'isChecked': false
    });
    int count = 1;
    users.forEach((element) {
      // print(element);
      checkboxes.add({
        "id": count,
        "username": element.username,
        'account_id': element.id,
        "isChecked": false,
      });
      count++;
    });

    return users;
  }

  getLastRecommendation(var recPost) async {
    dynamic id = await SessionManager().get("id");

    final response =
        await dio.get("/recommendation/history", data: {'account_id': id});

    var postsJson = response.data['payload']['posts'];

    List<Post> itemsList = List.from(postsJson.map((i) {
      Post post = Post.fromJson(jsonEncode(i["post"]));
      post.account!.username = i['post']['account']['username'];
      post.imageURL = "http://18.184.145.252/post/${post.id!}/image";
      return post;
    }));
    if (!itemsList.isEmpty) recPost.setRecommendationPost = itemsList.last;
  }

  @override
  void initState() {
    getFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var recPost = ref.watch(groupStateProvider);

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
                      child: TextButton(
                    child: Text(
                      SeeAll,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => History(),
                          ));
                    },
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetails(
                          post: recPost.getPost, index: recPost.getPost.id!),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 25,
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                      child: FutureBuilder(
                    future: getLastRecommendation(recPost),
                    builder: (context, snapshot) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20), // Image border
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(50), // Image radius
                                      child: recPost.getPost.title == null
                                          ? Image.network(
                                              'https://images.unsplash.com/photo-1565976469782-7c92daebc42e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                                              fit: BoxFit.cover)
                                          : Card(
                                              elevation: 17,
                                              child: Image.network(
                                                  recPost.getPost.imageURL!)),
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
                                        recPost.getPost.title != null
                                            ? recPost.getPost.likeCount
                                                .toString()
                                            : "")
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //Recipe Title
                              Padding(
                                padding: const EdgeInsets.only(bottom: 26.0),
                                child: Text(
                                    style: TextStyle(
                                        // letterSpacing: 1.4.sp,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17.sp,
                                        color: Colors.white),
                                    recPost.getPost.title != null
                                        ? recPost.getPost.title!
                                        : OldRecommendation),
                              ),

                              Text(
                                  style: TextStyle(
                                      letterSpacing: 0.8,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                  "${By} ${recPost.getPost.title != null ? recPost.getPost.account!.username : Owner}"),
                            ],
                          )
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
                      getRecommendation(recPost);
                    },
                    child: Text(ForSelf)),
                ElevatedButton(
                    onPressed: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Scaffold(
                                    floatingActionButton: FloatingActionButton(
                                      backgroundColor: Colors.green.shade700,
                                      onPressed: () async {
                                        dynamic id =
                                            await SessionManager().get("id");
                                        List<dynamic> users_id = [];

                                        checkboxes.forEach((element) {
                                          if (element['isChecked'] == true) {
                                            users_id.add(element['account_id']);
                                          }
                                        });

                                        final response = await dio.get(
                                            '/recommendation/group',
                                            data: {
                                              'account_id': id,
                                              'accounts': users_id
                                            });
                                        if (response.data["success"] == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(ThereIsNoInfo),
                                          ));
                                        } else {
                                          final json =
                                              response.data['payload']['post'];
                                          recPost.setRecommendationPost =
                                              Post.fromJson(jsonEncode(json));

                                          recPost.getPost.imageURL =
                                              "http://18.184.145.252/post/${json['id']}/image";
                                          // print(recPost.getPost);
                                          // logger.i(post);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(Recommended),
                                          ));
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(Get),
                                    ),
                                    floatingActionButtonLocation:
                                        FloatingActionButtonLocation.miniEndTop,
                                    appBar: AppBar(title: Text(AddFriends)),
                                    body: ListView.builder(
                                      itemCount: checkboxes.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      radius: 27.0,
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .green.shade300,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/yesilSef.jpg"),
                                                        radius: 25.0,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          checkboxes[index]
                                                              ['username'],
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Checkbox(
                                                        value: checkboxes[index]
                                                            ['isChecked'],
                                                        onChanged:
                                                            (bool? value) {
                                                          checkboxes[index][
                                                                  "isChecked"] =
                                                              value;
                                                          setState(() {});
                                                        })
                                                  ],
                                                ),
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
                      setState(() {});
                    },
                    child: Text(ForGroup)),
              ],
            )
          ],
        )));
  }
}

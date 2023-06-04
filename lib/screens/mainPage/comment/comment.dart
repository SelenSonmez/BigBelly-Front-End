// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../authentication/model/user_model.dart';
import '../../imports.dart';
import '../../model/post.dart';

class WriteComment extends StatelessWidget {
  WriteComment({super.key});

  late final TextEditingController _controller = TextEditingController();

  String comment = "";

  late Widget sentComment;

  late List comments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.h),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/defaultProfilePic.jpg"),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration:
                  const InputDecoration(labelText: "Write your comment..."),
              controller: _controller,
              onChanged: (String value) {
                comment = value;
              },
            ),
          ),
          TextButton(
              onPressed: () {
                sentComment = CommentTile(
                    comment: Comment(username: "aaa", comment: comment));
              },
              child: const Text("send"))
        ],
      ),
    );
  }
}

class Comment {
  String username;
  String comment;

  Comment({
    required this.username,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'comment': comment,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      username: map['account']['username'] as String,
      comment: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => "username: $username, comment: $comment";
  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key, required this.post});
  Post post;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late final TextEditingController _controller = TextEditingController();

  String comment = "";
  String username = "";
  late CommentTile sentComment;
  late List<CommentTile> comments = [];

  Future getComments() async {
    final response = await dio.get('/post/${widget.post.id}/comments');
    var json = response.data['payload']['comments'];
    List<Comment> commentsDatabase = List.from(json.map((i) {
      Comment comment = Comment.fromJson(jsonEncode(i));
      return comment;
    }));

    commentsDatabase.forEach(
      (element) {
        comments.add(CommentTile(
            comment:
                Comment(comment: element.comment, username: element.username)));
      },
    );

    setState(() {});
    print("******************");
    print(comments);
    print("******************");
  }

  @override
  void initState() {
    getComments();
    getSessionUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Comments"), actions: [
          Padding(
              padding: EdgeInsets.all(15.h), child: const Icon(Icons.comment))
        ]),
        body: Center(
            child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(
                height: 470.h,
                width: 600.w,
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return comments[index];
                  },
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade100),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 70.h),
                child: Container(
                  padding: EdgeInsets.all(10.0.h),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/defaultProfilePic.jpg"),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              labelText: "Write your comment..."),
                          controller: _controller,
                          onChanged: (String value) {
                            comment = value;
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            sentComment = CommentTile(
                                comment: Comment(
                                    comment: comment, username: username));
                            comments.add(sentComment);
                            _controller.clear();
                            dynamic id = await SessionManager().get('id');
                            Map<String, dynamic> fields = {
                              'post_id': widget.post.id,
                              'account_id': id,
                              'comment': comment
                            };
                            final response =
                                await dio.post('/post/comment', data: fields);
                            setState(() {});
                          },
                          child: const Text("send"))
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }

  Future<String> getSessionUsername() async {
    username = await SessionManager().get('username');
    return username;
  }
}

class CommentTile extends StatelessWidget {
  CommentTile({super.key, required this.comment, this.isReply = false});

  Comment comment;
  bool isReply;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isReply
          ? EdgeInsets.fromLTRB(50.w, 10.h, 10.w, 20.h)
          : EdgeInsets.all(10.h),
      child: Row(children: [
        CircleAvatar(
          backgroundImage:
              const AssetImage("assets/images/defaultProfilePic.jpg"),
          radius: 25.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15.w)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 8.0.h),
                      child: Text(comment.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child:
                        Text(comment.comment, style: TextStyle(fontSize: 16)),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     TextButton(
                  //       child: const Text("Like"),
                  //       onPressed: () {},
                  //     ),
                  //     // TextButton(onPressed: () {}, child: const Text("Reply")),
                  //     TextButton(onPressed: () {}, child: const Text("Edit"))
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<bool> checkSelfUsername(String commentUsername) async {
    if (comment.username == commentUsername) {
      debugPrint(comment.username);
      debugPrint(commentUsername);
      return true;
    }
    return false;
  }
}

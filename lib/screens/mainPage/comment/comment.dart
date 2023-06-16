// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bigbelly/screens/mainPage/texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../authentication/model/user_model.dart';
import '../../imports.dart';
import '../../model/post.dart';

// class WriteComment extends StatelessWidget {
//   WriteComment({super.key});

//   late final TextEditingController _controller = TextEditingController();

//   String comment = "";

//   late Widget sentComment;

//   late List comments;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15.0.h),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundImage: AssetImage("assets/images/defaultProfilePic.jpg"),
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(labelText: WriteYourComment),
//               controller: _controller,
//               onChanged: (String value) {
//                 comment = value;
//               },
//             ),
//           ),
//           TextButton(
//               onPressed: () {
//                 sentComment = CommentTile(
//                     comment: Comment(username: "aaa", comment: comment));
//               },
//               child: Text(Send))
//         ],
//       ),
//     );
//   }
// }

class Comment {
  int? id;
  String username;
  String comment;
  int? acc_id;

  Comment({
    this.id,
    this.acc_id,
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
      id: map['id'],
      username: map['account']['username'] as String,
      acc_id: map['account_id'],
      comment: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      "username: $username, comment: $comment, id: $id, acc_id: $acc_id";
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
    print("BBBBBBBBBBBBBBBB");
    print(commentsDatabase);

    commentsDatabase.forEach(
      (element) {
        comments.add(CommentTile(
            post: widget.post,
            comment: Comment(
                comment: element.comment,
                username: element.username,
                acc_id: element.acc_id,
                id: element.id)));
      },
    );

    setState(() {});
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
        appBar: AppBar(title: Text(Comments), actions: [
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
                          decoration:
                              InputDecoration(labelText: WriteYourComment),
                          controller: _controller,
                          onChanged: (String value) {
                            comment = value;
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            widget.post.commentCount++;
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
                          child: Text(Send))
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

class CommentTile extends StatefulWidget {
  CommentTile(
      {super.key, this.post, required this.comment, this.isReply = false});

  Comment comment;
  bool isReply;
  Post? post;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  String? reportMessage;

  bool isSelf = false;
  @override
  void initState() {
    super.initState();
    checkSelfUsername(widget.comment.username);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isReply
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
                color: Colors.green.shade300,
                borderRadius: BorderRadius.circular(15.w)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 8.0.h),
                      child: Text(widget.comment.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      // child: checkSelfUsername(comment.username) == true
                      //     ? Text("ALO")
                      //     : Text(comment.comment, style: TextStyle(fontSize: 16)),
                      child: isSelf == true
                          ? TextField(
                              onSubmitted: (value) {},
                              decoration: InputDecoration(
                                  hintText: widget.comment.comment),
                            )
                          : Text(widget.comment.comment))
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.flag_sharp),
          color: Colors.red.shade900,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(Report),
                  content: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(WhyCommentReport,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: TextField(
                            maxLength: 50,
                            onChanged: (value) {
                              reportMessage = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(Cancel)),
                    TextButton(
                      child: Text(Send),
                      onPressed: () async {
                        final id = await SessionManager().get("id");
                        Map<String, dynamic> params = {
                          'reason': reportMessage,
                          'commesnt_id': widget.comment.id,
                          'account_id': widget.comment.acc_id,
                        };
                        final response =
                            await dio.post('/report/comment', data: params);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(ReportHasSend),
                        ));
                      },
                    ),
                  ],
                );
              },
            );
          },
        )
      ]),
    );
  }

  Future<bool> checkSelfUsername(String commentUsername) async {
    dynamic username = await SessionManager().get("username");
    if (commentUsername == username) {
      isSelf = true;
      setState(() {});
      return isSelf;
    }
    return !isSelf;
  }
}

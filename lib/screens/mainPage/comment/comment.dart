import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../authentication/model/user_model.dart';
import '../../imports.dart';

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
                  username: "username from session",
                  comment: comment,
                );
              },
              child: const Text("send"))
        ],
      ),
    );
  }
}

class CommentScreen extends StatefulWidget {
  CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late final TextEditingController _controller = TextEditingController();

  String comment = "";
  String username = "";
  late Widget sentComment;

  List comments = [
    CommentTile(
      username: "seloaa",
      comment: "comment1",
    ),
    CommentTile(
      username: "seloaaa",
      comment: "comment2",
    ),
  ];
  @override
  void initState() {
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
                          onPressed: () {
                            sentComment = CommentTile(
                              username: username,
                              comment: comment,
                            );
                            comments.add(sentComment);
                            _controller.clear();
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
  CommentTile(
      {super.key,
      required this.username,
      required this.comment,
      this.isReply = false});

  final String username;
  final String comment;
  final bool isReply;

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
                      child: Text(username,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  checkSelfUsername(username) == true
                      ? TextFormField(
                          controller: _controller,
                          decoration: InputDecoration.collapsed(
                              hintText: comment, border: InputBorder.none),
                        )
                      : Text("AAAAA"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text("Like"),
                        onPressed: () {},
                      ),
                      TextButton(onPressed: () {}, child: const Text("Reply")),
                      TextButton(onPressed: () {}, child: const Text("Edit"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<bool> checkSelfUsername(String commentUsername) async {
    if (username == commentUsername) {
      debugPrint(username);
      debugPrint(commentUsername);
      return true;
    }
    return false;
  }
}

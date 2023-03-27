import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  late Widget sentComment;

  List comments = [
    const CommentTile(
      username: "selo",
      comment: "comment1",
    ),
    CommentTile(
      username: "selo",
      comment: "comment2",
    ),
    CommentTile(
      username: "selo",
      comment: "comment3",
    ),
    CommentTile(
      username: "selo",
      comment: "comment4",
    ),
    CommentTile(
      username: "selo",
      comment: "comment5",
    ),
    CommentTile(
      username: "selo",
      comment: "comment6",
    ),
    CommentTile(
      username: "selo",
      comment: "comment7",
    ),
    CommentTile(
      username: "selo",
      comment: "comment8",
    ),
    CommentTile(
      username: "selo",
      comment: "comment9",
    )
  ];

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
                              username: "username from session",
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
}

class CommentTile extends StatelessWidget {
  const CommentTile(
      {super.key,
      required this.username,
      required this.comment,
      this.isReply = false});

  final String username;
  final String comment;
  final bool isReply;

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
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Text(comment),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text("Like"),
                        onPressed: () {},
                      ),
                      TextButton(onPressed: () {}, child: const Text("Reply"))
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
}

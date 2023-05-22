import 'dart:convert';

import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/comment/comment.dart';
import 'package:bigbelly/screens/mainPage/widgets/collection_screen.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:like_button/like_button.dart';

import '../../model/post.dart';

class postReactions extends StatelessWidget {
  postReactions({super.key});

  int count = 1;

  void like() async {
    String id = await SessionManager().get('id');

    Map<String, dynamic> params = <String, dynamic>{
      'post_id': 5,
      'account_id': id,
    };
    //unlike
    if (count % 2 == 0) {
      debugPrint("unlike");
      final response = await dio.post('/post/unlike', data: params);
      debugPrint(response.data.toString());
      count++;
      return;
    }
    //like
    debugPrint("like");
    final response = await dio.post('/post/like', data: params);
    debugPrint(response.data.toString());
    count++;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
            size: 23.h,
            likeCount: 121,
            likeBuilder: (isLiked) {
              final color = isLiked ? Colors.red : Colors.green;
              return Icon(Icons.favorite, color: color);
            },
            onTap: _onLikeButtonTapped),
        const ReactionIconAndCount(
            icon: Icon(Icons.comment_rounded),
            isCountable: true,
            type: "comment"),
        const ReactionIconAndCount(
            icon: Icon(Icons.bookmark), type: "bookmark"),
        const ReactionIconAndCount(
            icon: Icon(Icons.replay_sharp), type: "recipe"),
        const ReactionIconAndCount(icon: Icon(Icons.star), type: "star"),
        const ReactionIconAndCount(icon: Icon(Icons.more_vert), type: "more"),
      ],
    );
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    like();
    return !isLiked;
  }
}

class ReactionIconAndCount extends StatefulWidget {
  const ReactionIconAndCount(
      {super.key,
      required this.icon,
      this.isCountable = false,
      required this.type});
  final Icon icon;
  final bool isCountable;
  final String type;

  @override
  State<ReactionIconAndCount> createState() => _ReactionIconAndCountState();
}

class _ReactionIconAndCountState extends State<ReactionIconAndCount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.type != "more"
            ? IconButton(
                color: mainThemeColor,
                iconSize: 23.h,
                icon: widget.icon,
                onPressed: () {
                  switch (widget.type) {
                    case "comment":
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CommentScreen())));
                      break;
                    case "bookmark":
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const _CollectionModalBottom();
                          });
                      break;
                    case "recipe":
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Re-cipe"),
                              content: Text(
                                "This post will be republished on your feed",
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Accept',
                                      style: TextStyle(fontSize: 18)),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Cancel',
                                      style: TextStyle(fontSize: 18)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                      break;
                    case "star":
                      break;
                  }
                },
              )
            : PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.green),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Archive (TODO: only self post)"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Report"),
                    ),
                    // PopupMenuItem<int>(value: 2, child: Text("Details")),
                  ];
                },
                onSelected: (value) {
                  // if (value == 2) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PostDetails(),
                  //       ));
                  // }
                },
              ),
        Text(
          widget.isCountable ? "2234" : " ",
        )
      ],
    );
  }
}

class _CollectionModalBottom extends StatefulWidget {
  const _CollectionModalBottom({super.key});

  @override
  State<_CollectionModalBottom> createState() => _CollectionModalBottomState();
}

class _CollectionModalBottomState extends State<_CollectionModalBottom> {
  bool isNewCollectionClicked = false;

  final TextEditingController _controller = TextEditingController();

  String collectionName = "";

  final _formKey = GlobalKey<FormState>();

  List<CollectionRow> collections = [];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainThemeColor,
          title: Text("Collections"),
          actions: [
            TextButton(
                onPressed: () {
                  isNewCollectionClicked = true;
                  setState(() {});
                },
                child: const Text(
                  "+ New Collection",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              isNewCollectionClicked
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                    hintText: "Enter Collection Name"),
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    collectionName = newValue;
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _formKey.currentState!.save();
                                  createCollection();
                                  _controller.clear();
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: FutureBuilder(
                    future: getCollections(),
                    builder: (context, snapshot) {
                      if (collections.isEmpty) {
                        return const Center(
                            child: Text('You have no collections.'));
                      } else {
                        return ListView.builder(
                          itemCount: collections.length,
                          itemBuilder: (context, index) {
                            return CollectionRow(
                              id: collections[index].id,
                              title: collections[index].title,
                              updateCollections: () => setState(() {}),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  Future createCollection() async {
    final id = await SessionManager().get('id');
    const uri = '/collection/create';
    Response response =
        await dio.post(uri, data: {'name': collectionName, 'account_id': id});

    switch (response.data['message']) {
      case 'Request has succeed':
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Collection created!")));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));
        break;
    }
  }

  Future getCollections() async {
    List<CollectionRow> collection = [];
    final id = await SessionManager().get('id');
    const uri = '/collection/get';
    Response response = await dio.get(uri, data: {'account_id': id});

    switch (response.data['message']) {
      case 'Request has succeed':
        response.data['payload']['collections'].forEach((v) {
          collection.add(CollectionRow(id: v['id'], title: v['name']));
        });
        collections = collection;
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));
        break;
    }
  }
}

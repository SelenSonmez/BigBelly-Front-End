import 'dart:convert';

import 'package:bigbelly/constants/providers/postList_provider.dart';
import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/comment/comment.dart';
import 'package:bigbelly/screens/mainPage/widgets/collection_screen.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:like_button/like_button.dart';

import '../../model/post.dart';

class postReactions extends ConsumerWidget {
  postReactions(
      {super.key,
      required this.post,
      this.isUserSelf = false,
      required this.index});
  Post post;
  int index;
  bool isUserSelf;
  void like() async {
    String id = await SessionManager().get('id');

    Map<String, dynamic> params = <String, dynamic>{
      'post_id': post.id,
      'account_id': id,
    };
    //unlike
    if (post.isLiked!) {
      final response = await dio.post('/post/unlike', data: params);

      post.isLiked = false;
      return;
    }
    //like
    final response = await dio.post('/post/like', data: params);
    post.isLiked = true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
            isLiked: post.isLiked,
            size: 23.h,
            likeCount: post.likes!.length,
            likeBuilder: (isLiked) {
              final color = isLiked ? Colors.red : Colors.green;
              return Icon(Icons.favorite, color: color);
            },
            onTap: (isLiked) async {
              String id = await SessionManager().get('id');
              Map<String, dynamic> params = <String, dynamic>{
                'post_id': post.id,
                'account_id': id,
              };
              //unlike
              if (post.isLiked!) {
                final response = await dio.post('/post/unlike', data: params);

                post.isLiked = false;
                ref.watch(postListProvider).editPost(post, index);
                return !isLiked;
              }
              //like
              final response = await dio.post('/post/like', data: params);
              post.isLiked = true;
              ref.watch(postListProvider).editPost(post, index);

              return !isLiked;
            }),
        ReactionIconAndCount(
            icon: Icon(Icons.comment_rounded),
            isCountable: true,
            type: "comment",
            post: post),
        ReactionIconAndCount(
            icon: Icon(Icons.bookmark), type: "bookmark", post: post),
        ReactionIconAndCount(
            icon: Icon(Icons.replay_sharp), type: "recipe", post: post),
        // ReactionIconAndCount(icon: Icon(Icons.star), type: "star", post: post),
        ReactionIconAndCount(
          icon: Icon(Icons.more_vert),
          type: "more",
          post: post,
          isUserSelf: isUserSelf,
        ),
      ],
    );
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    like();
    return !isLiked;
  }
}

class ReactionIconAndCount extends StatefulWidget {
  ReactionIconAndCount(
      {super.key,
      required this.icon,
      this.isCountable = false,
      required this.type,
      this.isUserSelf = false,
      this.post});
  final Icon icon;
  final bool isCountable;
  final String type;
  bool isUserSelf;
  Post? post;

  @override
  State<ReactionIconAndCount> createState() => _ReactionIconAndCountState();
}

class _ReactionIconAndCountState extends State<ReactionIconAndCount> {
  @override
  void initState() {
    // isSelf();
    super.initState();
  }

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
                              builder: ((context) =>
                                  CommentScreen(post: widget.post!))));
                      break;
                    case "bookmark":
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _CollectionModalBottom(post: widget.post);
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
                  }
                },
              )
            : PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.green),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                itemBuilder: (context) {
                  List<PopupMenuEntry<Object?>> list = [];
                  if (widget.isUserSelf) {
                    list = [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Archive"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Report"),
                      ),
                    ];
                  } else {
                    list = [
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Report"),
                      ),
                    ];
                  }
                  return list;
                  // PopupMenuItem<int>(value: 2, child: Text("Details")),
                },
                onSelected: (value) async {
                  if (value == 0) {
                    final response =
                        await dio.post('/post/${widget.post!.id}/archive');
                    if (response.data['success'] == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.brown.shade400,
                        content: const Text('Post Archived'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.brown.shade400,
                        content: const Text("Post can't be archived right now"),
                      ));
                    }
                  }
                  if (value == 1) {
                    String reportMessage = "";
                    if (!mounted) return;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Report"),
                          content: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Why do you want to report this post?"),
                                TextField(
                                  maxLength: 50,
                                  onChanged: (value) {
                                    reportMessage = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Send"),
                              onPressed: () async {
                                final id = await SessionManager().get("id");
                                Map<String, dynamic> params = {
                                  'reason': reportMessage,
                                  'post_id': widget.post!.id,
                                  'account_id': id,
                                };
                                final response = await dio.post('/report/post',
                                    data: params);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: const Text('Report has send'),
                                ));
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"))
                          ],
                        );
                      },
                    );
                  }
                },
              ),
        Text(
          widget.isCountable ? "2234" : " ",
        )
      ],
    );
  }

  // Future<bool> isSelf() async {
  //   dynamic id = await SessionManager().get("id");
  //   print(widget.post!.account!.id == int.parse(id));
  //   widget.isSelf = widget.post!.account!.id == int.parse(id);
  //   print("PPPPPPPPPPPPPPPPPPPP");
  //   print(widget.isSelf);
  //   setState(() {});
  //   return widget.isSelf;
  // }
}

class _CollectionModalBottom extends ConsumerStatefulWidget {
  _CollectionModalBottom({super.key, this.post});
  Post? post;

  @override
  ConsumerState<_CollectionModalBottom> createState() =>
      _CollectionModalBottomState();
}

class _CollectionModalBottomState
    extends ConsumerState<_CollectionModalBottom> {
  bool isNewCollectionClicked = false;

  final TextEditingController _controller = TextEditingController();

  String collectionName = "";

  final _formKey = GlobalKey<FormState>();

  List<CollectionRow> collections = [];

  Map<int, List<Post>?> collectionPosts = {};

  Map<int, bool> isPostInCollection = {};

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
                      if (collections.isEmpty && isPostInCollection.isEmpty) {
                        return const Center(
                            child: Text('You have no collections.'));
                      } else {
                        return ListView.builder(
                          itemCount: collections.length,
                          itemBuilder: (context, index) {
                            return CollectionRow(
                              post: widget.post,
                              id: collections[index].id,
                              title: collections[index].title,
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
        response.data['payload']['collections'].forEach((v) async {
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

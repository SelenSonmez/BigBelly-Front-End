import 'dart:convert';

import 'package:bigbelly/screens/mainPage/texts.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/collections/collection_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../../constants/providers/post_provider.dart';
import '../../imports.dart';
import '../../model/post.dart';

class CollectionRow extends ConsumerStatefulWidget {
  CollectionRow({
    super.key,
    required this.id,
    required this.title,
    this.post,
    this.isProfileCollections = false,
  });
  final String title;
  final int id;
  bool isProfileCollections;
  late bool isPostInCollection = false;
  late bool isDeleted = false;
  Map<int, List<Post>?> collectionPosts = {};
  Post? post;
  @override
  ConsumerState<CollectionRow> createState() => _CollectionRowState();
}

class _CollectionRowState extends ConsumerState<CollectionRow> {
  @override
  void initState() {
    getCollectionPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDeleted
        ? Container()
        : Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.asset(
                      width: 80,
                      height: 80,
                      "assets/images/hamburger.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: !widget.isProfileCollections
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                widget.isPostInCollection == false
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outlined,
                                          size: 33,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          addPostToCollection(widget.post!.id!);
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          deletePostFromCollection(
                                              widget.post!.id!);
                                        },
                                      ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            deleteCollectionDialog(context));
                                    setState(() {});
                                  },
                                )
                              ],
                            )
                          : const SizedBox()),
                ],
              ),
              const Divider(
                thickness: 2,
              )
            ],
          );
  }

  Widget deleteCollectionDialog(BuildContext context) {
    return AlertDialog(
      title: Text(Warning),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$AreYouSureToDeleteCollection ${widget.title} ?'),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            deleteCollection();
            Navigator.of(context).pop();
          },
          child: Text(Yes),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(Close),
        ),
      ],
    );
  }

  Future deleteCollection() async {
    final uri = '/collection/${widget.id}/delete';
    Response response = await dio.post(uri);

    switch (response.data['message']) {
      case 'Request has succeed':
        widget.isDeleted = true;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(CollectionDeleted)));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));
        break;
    }
  }

  Future addPostToCollection(int postID) async {
    final uri = '/collection/${widget.id}/addPost';
    Response response = await dio
        .post(uri, data: {'collection_id': widget.id, 'post_id': postID});

    switch (response.data['message']) {
      case 'Request has succeed':
        widget.isPostInCollection = true;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("${PostAddedToCollection} ${widget.title}!")));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));
        break;
    }
  }

  Future deletePostFromCollection(int postID) async {
    final uri = '/collection/${widget.id}/deletePost';
    Response response = await dio
        .post(uri, data: {'collection_id': widget.id, 'post_id': postID});

    switch (response.data['message']) {
      case 'Request has succeed':
        widget.isPostInCollection = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("${PostDeletedFromCollection} ${widget.title}!")));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));
        break;
    }
  }

  void doesCollectionContainPost() async {
    var post = ref.watch(postProvider);

    for (Post p in widget.collectionPosts![widget.id]!) {
      if (p.id == post.getPost.id) {
        widget.isPostInCollection = true;
      } else {
        widget.isPostInCollection = false;
      }
    }
    setState(() {});
  }

  Future getCollectionPosts() async {
    var uri = '/collection/${widget.id}/getPosts';
    Response response = await dio.get(uri);
    var postsJson = response.data['payload']['posts'];

    switch (response.data['message']) {
      case 'Request has succeed':
        widget.collectionPosts![widget.id] =
            List.from(postsJson.map((i) => Post.fromJson(jsonEncode(i))));
        doesCollectionContainPost();

        break;
      default:
        break;
    }
  }

  Future checkPostInCollection() async {
    await getCollectionPosts();
    doesCollectionContainPost();
  }
}

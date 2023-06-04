import 'dart:convert';

import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:bigbelly/screens/model/post.dart';
import 'package:bigbelly/screens/mainPage/widgets/collection_screen.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/collections/collection_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../../imports.dart';

class CollectionsTab extends ConsumerStatefulWidget {
  CollectionsTab({super.key});

  @override
  ConsumerState<CollectionsTab> createState() => _CollectionsTabState();
}

class _CollectionsTabState extends ConsumerState<CollectionsTab> {
  List<CollectionRow> collections = [];

  Map<int, List<Post>?> collectionPosts = {};

  bool isPostInCollection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(),
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
                        return GestureDetector(
                          onTap: () {
                            getCollectionPosts(collections[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CollectionPosts(
                                        collectionName:
                                            collections[index].title,
                                        collectionPosts: collectionPosts[
                                            collections[index].id],
                                      ))),
                            );
                          },
                          child: CollectionRow(
                            id: collections[index].id,
                            title: collections[index].title,
                            isProfileCollections: true,
                          ),
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

  Future getCollections() async {
    List<CollectionRow> collection = [];
    final id = await SessionManager().get('id');
    const uri = '/collection/get';
    Response response = await dio.get(uri, data: {'account_id': id});

    switch (response.data['message']) {
      case 'Request has succeed':
        response.data['payload']['collections'].forEach((v) {
          collection.add(CollectionRow(id: v['id'], title: v['name']));
          getCollectionPosts(v['id']);
        });
        collections = collection;
        break;
      default:
        break;
    }
  }

  Future getCollectionPosts(int collectionID) async {
    var uri = '/collection/$collectionID/getPosts';
    Response response = await dio.get(uri);
    var postsJson = response.data['payload']['posts'];

    switch (response.data['message']) {
      case 'Request has succeed':
        collectionPosts[collectionID] =
            List.from(postsJson.map((i) => Post.fromJson(jsonEncode(i))));

        break;
      default:
        break;
    }
  }
}

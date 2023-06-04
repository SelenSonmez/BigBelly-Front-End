import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:bigbelly/screens/model/post.dart';
import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class CollectionPosts extends StatelessWidget {
  CollectionPosts({super.key, this.collectionPosts, this.collectionName});

  String? collectionName;
  List<Post>? collectionPosts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Text(collectionName!),
      ),
      body: GridView.builder(
          itemCount: collectionPosts!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(right: 3, top: 3, left: 3),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MainPage(
                              // postIndexToBeShown: index,
                              // isVisible: false,
                              ))),
                    );
                  },
                  child: Image.network(
                    "http://18.184.145.252/post/${collectionPosts![index].id!}/image",
                    fit: BoxFit.contain,
                  ),
                ));
          }),
    );
  }
}

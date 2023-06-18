// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
import 'package:bigbelly/screens/model/post.dart';
import 'package:bigbelly/screens/post_details/post_details.dart';
import 'package:bigbelly/screens/profilePage/widgets/profile_page.dart';
import 'package:bigbelly/screens/search/widgets/profile_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as r;
import '../authentication/model/user_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          BigBellyAppBar(
              trailingWidget: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  icon: Icon(Icons.tag),
                  iconSize: 35,
                  onPressed: () async {
                    await showSearch(
                        context: context,
                        delegate:
                            BigBellySearchDelegate(isUserSearched: false));
                  },
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: IconButton(
                    icon: Icon(size: 30.w, Icons.search),
                    onPressed: () async {
                      await showSearch(
                          context: context, delegate: BigBellySearchDelegate());
                    },
                  )),
            ],
          )),
        ];
      },
      body: Container(),
    ));
  }
}

class BigBellySearchDelegate extends SearchDelegate {
  BigBellySearchDelegate({this.isUserSearched = true});
  bool isUserSearched;
  User? user;
  List<Post?> posts = [];
  late User searchedUser;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty)
              close(context, null);
            else
              query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null));
  }

  //searched and clicked profile of user will display
  @override
  Widget buildResults(BuildContext context) {
    return r.Consumer(builder: (context, ref, child) {
      final userValue = ref.watch(userProvider);
      userValue.setUser = searchedUser;
      return ProfilePage();
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future:
            query != "" ? (isUserSearched ? searchUser() : searchPost()) : null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return query == ""
                ? Container()
                : const Center(child: CircularProgressIndicator());
          } else {
            return isUserSearched
                ? ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: ProfileTile(
                              username: user!.username!,
                              followerCount: user!.followers!.length),
                          onTap: () {
                            searchedUser = user!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        buildResults(context)));
                          });
                    })
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: ProfileTile(
                            username: posts[index]!.title!,
                            imageURL: posts[index]!.imageURL,
                          ),
                          onTap: () {
                            /* posts[index]!.imageURL =
                                "http://18.184.145.252/post/${posts[index]!.id!}/image";*/
                            Post post = posts[index]!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetails(post: post, index: index)));
                          });
                    });
          }
        });
  }

  Future<User?> searchUser() async {
    const uri = "/profile/search";
    Response response = await dio.get(uri, data: {'username': query});
    switch (response.data['message']) {
      case 'Username could not found':
        break;
      case "Request has succeed!":
        user = User.fromJson(response.data['payload']['user']);
        print(user!.followers!.length);
        break;
    }
    return user;
  }

  Future<List<Post?>> searchPost() async {
    posts = [];
    Post? post;
    const uri = "/post/search-by-tag";
    Response response = await dio.get(uri, data: {'tag': query});
    switch (response.data['message']) {
      case 'Post could not found':
        break;
      case "Request has succeed!":
        response.data['payload']['posts'].forEach((v) {
          post = Post.fromMap(v);
          post!.imageURL = "http://18.184.145.252/post/${post!.id!}/image";
          posts.add(post);
        });
        break;
    }

    return posts;
  }
}

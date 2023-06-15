// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
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
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => FollowerRequest()));
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
      body: Container(child: Text("alo")),
    ));
  }
}

class BigBellySearchDelegate extends SearchDelegate {
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
        future: query != "" ? search() : null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return query == ""
                ? Container()
                : const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: ProfileTile(
                          username: snapshot.data!.username!,
                          followerCount: snapshot.data!.followers!.length),
                      onTap: () {
                        searchedUser = snapshot.data!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => buildResults(context)));
                      });
                });
          }
        });
  }

  Future<User?> search() async {
    User? user;
    const uri = "/profile/search";
    Response response = await dio.get(uri, data: {'username': query});
    switch (response.data['message']) {
      case 'Username could not found':
        break;
      case "Request has succeed!":
        user = User.fromJson(response.data['payload']['user']);
        break;
    }
    return user;
  }
}

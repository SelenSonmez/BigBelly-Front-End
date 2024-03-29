import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/constants/providers/meal_post_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../../constants/providers/user_provider.dart';
import '../../../../model/post.dart';
import '../../../../recommendation/recommendation_screen.dart';

class MealMenu extends ConsumerWidget {
  MealMenu({super.key});
  List<Post> itemsList = [];

  Future<List<Post>> getPosts([UserModel? user]) async {
    final response = await dio.get('/profile/${user!.getUser.id}/posts');
    var postsJson = response.data['payload']['posts'];
    // List<Post> institutionalPosts = [];
    // itemsList = [];

    for (var element in postsJson) {
      Post post = Post.fromJson(jsonEncode(element));
      if (element['institutional_post'] != null) {
        itemsList.add(post);
      }
      // post.account = User.fromJson(response.data['payload']['account']);
    }

    //print(itemsList);
    print(postsJson);
    // user.setPostCount(itemsList.length);
    // const ProfileInfo();
    return itemsList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    //var menuIngredient = ref.watch(mealPostProvider).getMenuIngredient;
    //print(menuIngredient.id);
    return FutureBuilder(
      future: getPosts(user),
      builder: (context, snapshot) {
        return Column(
          children: [
            Text("Menu",
                style: GoogleFonts.slabo27px(
                    color: Colors.green.shade800,
                    fontSize: 27,
                    letterSpacing: 2)),
            Divider(
              thickness: 2,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 8.0),
                                    child: Text(snapshot.data![index].title!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 40,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: snapshot
                                              .data![index].ingredients!.length,
                                          physics: BouncingScrollPhysics(),
                                          // menuIngredient.ingredients.length,
                                          itemBuilder: (context, subIndex) {
                                            return Text(
                                              snapshot.data![index].isHidden ==
                                                      false
                                                  ? snapshot
                                                          .data![index]
                                                          .ingredients![
                                                              subIndex]
                                                          .name +
                                                      " ,"
                                                  : "",
                                              style: TextStyle(fontSize: 15),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 90,
                                      height: 90,
                                      alignment: Alignment.bottomLeft,
                                      child: Image.network(
                                          "http://18.184.145.252/post/" +
                                              snapshot.data![index].id
                                                  .toString() +
                                              "/image")),
                                  Row(
                                    children: [
                                      const Icon(Icons.monetization_on,
                                          color: Colors.green),
                                      Text(snapshot.data![index].price!,
                                          style: TextStyle(fontSize: 15))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.shade300,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}

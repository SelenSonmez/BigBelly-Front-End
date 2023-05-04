import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'imports.dart';
import 'mainPage/main_page_imports.dart';

class PostListView extends StatelessWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, i) {
        return Column(children: [
          Image.asset('assets/images/hamburger.jpg'),
          Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  PostitleAndTags(),
                  PostOwnerAndDate(),
                  postReactions(),
                  Divider(thickness: 2)
                ],
              )),
        ]);
      }, childCount: 10),
    );
  }
}
